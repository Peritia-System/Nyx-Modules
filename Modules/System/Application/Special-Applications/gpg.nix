# GPG (System Module)
#
# Provides:
#   - GnuPG installation (gpg, pinentry)
#   - gpg-agent system service (with optional SSH support)
#   - Desktop secrets integration (gnome-keyring, seahorse)
#
# Options:
#   - enable          -> Enable GnuPG system module
#   - enableSSHSupport -> Enable SSH agent emulation in gpg-agent
#   - enableSeahorse   -> Enable Seahorse (GUI key manager)
#   - pinentry.package -> Pinentry package (default: pkgs.pinentry-all)
#
{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.gpg;
in {
  options.nyx-module.system.gpg = {
    enable = lib.mkEnableOption "Enable GnuPG (system module)";

    enableSSHSupport = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable SSH agent emulation support in gpg-agent.  
        This allows you to use your GPG keys for SSH authentication.
      '';
    };

    enableSeahorse = lib.mkEnableOption "Enable Seahorse (GUI key manager)";

    pinentry.package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pinentry-all;
      description = ''
        The pinentry package to use.  
        By default, `pkgs.pinentry-all` is installed, which includes
        all common backends (tty, curses, gtk2, qt, gnome3).
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable gpg-agent with optional SSH support
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = cfg.enableSSHSupport;
    };

    # Enable gnome-keyring (for desktop secret storage)
    services.gnome.gnome-keyring.enable = true;

    # Optional GUI for secrets management
    programs.seahorse.enable = cfg.enableSeahorse;

    # Base packages + user-supplied pinentry
    environment.systemPackages = with pkgs; [
      gnupg
      gnome-keyring
      cfg.pinentry.package
    ];
  };
}
