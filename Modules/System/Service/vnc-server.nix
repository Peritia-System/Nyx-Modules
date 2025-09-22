# TigerVNC Multi-Session Server Module
#
# This module provides:
#   - A systemd service for running a TigerVNC multi-session server
#   - Automatic password hashing at build time (via `vncpasswd -f`)
#   - Desktop session registration (.desktop file) for the chosen environment
#   - Optional firewall opening for the configured display port
#
# Configuration Options:
#   enable         – Enable the VNC server service (boolean)
#   user           – System user that owns and runs the VNC server (string)
#   password       – Plaintext password (hashed at build time; first 8 chars significant)
#   displayNumber  – X display number (e.g. `1` → :1 → TCP port 5901)
#   openFirewall   – Open the firewall for the selected display port (boolean)
#   session        – Name of the desktop session (e.g. "xfce", "plasma")
#   geometry       – Default screen resolution (e.g. "1920x1080")
#   sessionCommand – Command to start the X session (full path)
#
# Example Usage:
#   nyx-module.system.service.vnc = {
#     enable = true;
#     user = "myuser";
#     password = "secret12";
#     session = "xfce";
#     geometry = "1280x800";
#   };
#

{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.nyx-module.system.service.vnc;

  # Resolve the user home safely even if the user isn't declared yet.
  userHome = lib.attrByPath ["users" "users" cfg.user "home"] "/home/${cfg.user}" config;

  # Only generate passwd file if enabled, otherwise null
  generatedPasswdFile =
    if cfg.enable
    then
      pkgs.runCommand "tigervnc-passwd" {
        buildInputs = [pkgs.tigervnc];
      } ''
        mkdir -p $out
        echo -n "${cfg.password}" | vncpasswd -f > $out/passwd
      ''
    else null;
in {
  options.nyx-module.system.service.vnc = {
    enable = mkEnableOption "Enable a TigerVNC multi-session server.";

    user = mkOption {
      type = types.str;
      example = "myuser";
      description = "System user that owns and runs the VNC server.";
    };

    password = mkOption {
      type = types.str;
      example = "secret12";
      description = ''
        Plaintext VNC password. Will be hashed at build time using
        `vncpasswd -f`. **Warning:** Stored in the Nix store, only
        the first 8 characters are significant.
      '';
    };

    displayNumber = mkOption {
      type = types.int;
      default = 1;
      description = "X display number (:1 => TCP 5901).";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "Open the firewall for the selected display port.";
    };

    session = mkOption {
      type = types.str;
      default = "xfce";
      example = "plasma";
      description = "Name of the desktop session (matches .desktop file).";
    };

    geometry = mkOption {
      type = types.str;
      default = "1920x1080";
      description = "Default VNC display resolution.";
    };

    sessionCommand = mkOption {
      type = types.str;
      default = "${pkgs.xterm}/bin/xterm";
      example = "${pkgs.xfce4-session}/bin/startxfce4";
      description = "Command to start the X session.";
    };
  };

  config = mkIf cfg.enable {
    # Install required packages
    environment.systemPackages = with pkgs; [
      tigervnc
      xorg.xauth
      xorg.xinit
    ];

    # Enable X server and desktop environment
    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      xkb.layout = "de";
      displayManager.defaultSession = cfg.session; # fixed option path
    };

    # Configure session
    services.xserver.displayManager.session = [
      {
        manage = "desktop";
        name = cfg.session;
        start = ''
          ${cfg.sessionCommand} &
          waitPID=$!
        '';
      }
    ];

    # Install a custom .desktop file for session
    environment.etc."xdg/xsessions/${cfg.session}.desktop".text = ''
      [Desktop Entry]
      Name=${cfg.session}
      Comment=Custom ${cfg.session} session for VNC
      Exec=${cfg.sessionCommand}
      Type=Application
    '';

    system.activationScripts.linkCustomSession = ''
      mkdir -p /usr/share/xsessions
      ln -sf /etc/xdg/xsessions/${cfg.session}.desktop \
             /usr/share/xsessions/${cfg.session}.desktop
    '';

    # Systemd service for VNC server
    systemd.services.vncserver = {
      description = "TigerVNC server on :${toString cfg.displayNumber}";
      after = ["network.target" "syslog.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        TimeoutStartSec = "60s";
        WorkingDirectory = userHome;
        PIDFile = "${userHome}/.vnc/%H:${toString cfg.displayNumber}.pid";

        Environment = "PATH=${pkgs.xorg.xinit}/bin:${pkgs.tigervnc}/bin:${pkgs.xorg.xauth}/bin:/run/current-system/sw/bin";

        ExecStartPre = pkgs.writeShellScript "prepare-vnc" ''
            mkdir -p ${userHome}/.vnc
            cp ${generatedPasswdFile}/passwd ${userHome}/.vnc/passwd
            chmod 600 ${userHome}/.vnc/passwd
            chown ${cfg.user}:users ${userHome}/.vnc/passwd

            mkdir -p ${userHome}/.config/tigervnc
            cat > ${userHome}/.config/tigervnc/config <<EOF
          session=${cfg.session}
          geometry=${cfg.geometry}
          alwaysshared
          rfbauth=${userHome}/.vnc/passwd
          EOF

            # Minimal xstartup with logging
            cat > ${userHome}/.vnc/xstartup <<'EOF'
          #!/bin/sh

          export DISPLAY=:${toString cfg.displayNumber}
          export XAUTHORITY="$HOME/.Xauthority"
          export XDG_RUNTIME_DIR="/run/user/$(id -u)"
          export XKL_XMODMAP_DISABLE=1
          export GTK_USE_PORTAL=0
          export PULSE_SERVER=unix:/run/user/$(id -u)/pulse/native
          export PULSE_SERVER=tcp:localhost:4714
          # Log:
          echo "=== Starting VNC session on $(date) ===" >> "$HOME/.vnc/xstartup.log" 2>&1

            # Load user profile to get PATH, XDG vars, etc.
            if [ -f /etc/profile ]; then
              . /etc/profile
            fi

            # Source NixOS user environment
            if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
              . "$HOME/.nix-profile/etc/profile.d/nix.sh"
            fi

            export XDG_SESSION_TYPE=x11
            export XDG_CURRENT_DESKTOP=XFCE
            export XDG_CONFIG_HOME="$HOME/.config"

          ${cfg.sessionCommand} >> "$HOME/.vnc/xstartup.log" 2>&1 &

          wait $!
          EOF

                    chmod +x ${userHome}/.vnc/xstartup
                    chown ${cfg.user}:users ${userHome}/.vnc/xstartup
                    touch ${userHome}/.vnc/xstartup.log
                    chown ${cfg.user}:users ${userHome}/.vnc/xstartup.log
                    chmod 600 ${userHome}/.vnc/xstartup.log
        '';

        ExecStart = "${pkgs.tigervnc}/bin/vncserver :${toString cfg.displayNumber}";
        ExecStop = "${pkgs.procps}/bin/pkill -f 'Xvnc :${toString cfg.displayNumber}' || true";
      };
    };

    environment.etc."X11/Xsession" = {
      text = ''
        #!/bin/sh
        LOGFILE="$HOME/.vnc/xsession.log"
        mkdir -p "$HOME/.vnc"
        touch "$LOGFILE"
        chmod 600 "$LOGFILE"

        echo "=== Xsession started on $(date) ===" >> "$LOGFILE" 2>&1

        if [ -x "$HOME/.vnc/xstartup" ]; then
          echo "Found xstartup, executing..." >> "$LOGFILE" 2>&1
          exec "$HOME/.vnc/xstartup" >> "$LOGFILE" 2>&1
        else
          echo "No ~/.vnc/xstartup found, cannot start session." >> "$LOGFILE" 2>&1
          echo "No ~/.vnc/xstartup found, cannot start session." >&2
          exit 1
        fi
      '';
      mode = "0755";
    };

    # Optionally open firewall
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      (5900 + cfg.displayNumber)
    ];
  };
}
