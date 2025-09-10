{ config, lib, pkgs, ... }:

{
  nyx-module = {
    system = {
      docker = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to the docker group.";
        username = "alice";
        
        # mkOption type=lib.types.bool
        # Whether to enable Docker service on boot.";
        enableOnBoot = true;
        
        # mkEnableOption (bool)
        rootless = true;
        
      };

      openssh = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.bool
        # Whether to allow password authentication.";
        passwordAuth = false;
        
        # mkOption type=lib.types.str
        # Whether to permit root login via SSH.";
        permitRootLogin = "no";
        
      };

      podman = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to the podman group.";
        username = "alice";
        
      };

      vm = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to virtualization groups.";
        username = "alice";
        
      };

      zsh = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        ohMyZsh = true;
        
        # mkOption type=lib.types.str
        # oh-my-zsh theme to use.";
        theme = "xiong-chiamiov-plus";
        
        # mkOption type=lib.types.listOf lib.types.str
        # List of oh-my-zsh plugins to enable.";
        plugins = [ "git" ];
        
      };

      steam = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        remotePlay = true;
        
        # mkEnableOption (bool)
        dedicatedServer = true;
        
        # mkEnableOption (bool)
        localNetworkGameTransfers = true;
        
      };

      flatpak = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      wireshark = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to the wireshark group.";
        username = "alice";
        
      };

      c-compiler = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      go = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      lua = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      python = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      rust = {
        # mkEnableOption (bool)
        enable = true;
        
      };

    };

    home = {
      brave = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        standard = true;
        
        # mkOption type=lib.types.listOf lib.types.str
        # List of additional Brave extension IDs to install.";
        extra = [];
        
      };

      signal-desktop = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Package to install for signal-desktop.";
        package = pkgs.signal-desktop;
        
      };

      vesktop = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Package to install for vesktop.";
        package = pkgs.vesktop;
        
      };

      rustdesk = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # ''
        package = pkgs.rustdesk;
        
      };

      vscodium = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        standard = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # List of extra VSCodium extensions to install.";
        extra = [];
        
      };

      classic-game-collection = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      prismlauncher = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        includeFfmpeg = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # List of Java runtimes to make available for PrismLauncher.";
        jdks = [ pkgs.jdk17 ];
        
      };

      cava = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.attrs
        settings =       default = {;
        
        # mkOption type=lib.types.nullOr lib.types.lines
        # ''
        configText = null;
        
      };

      spotify = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # ''
        package = pkgs.spotify;
        
      };

      camera = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Camera GUI package to install.";
        package = pkgs.snapshot;
        
      };

      image-viewer = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Image viewer package to install (e.g. gwenview, feh, imv).";
        package = pkgs.gwenview;
        
      };

      krita = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      kdenlive = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      video-player = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # List of video/media players to install (e.g. vlc, mpv, celluloid).";
        packages = [ pkgs.vlc ];
        
      };

      zoom = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Zoom package to install (e.g., pkgs.zoom-us).";
        package = pkgs.zoom-us;
        
      };

      obsidian = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      libreoffice = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      pdf-reader = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # PDF or scanning GUI package to install (e.g. Okular, Evince, Xournal++).";
        package = pkgs.kdeApplications.okular;
        
      };

      printer-scan = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Printer/scanner GUI package to install.";
        package = pkgs.simple-scan;
        
      };

      thunderbird = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      protonvpn = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      tools = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # Extra CLI tools to install in addition to the defaults.";
        extra = [];
        
      };

      zsh = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      private-webapps = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Browser package to use for private webapps.";
        browser = pkgs.chromium;
        
      };

      work-webapps = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Browser package to use for private webapps.";
        browser = pkgs.chromium;
        
      };

    };

    hardware = {
      bluetooth = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      custom-kernel-surfacepro-kbl = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.enum [ "stable" "longtime" ]
        # Choose which kernel version nixos-hardware will build for Surface Pro.";
        kernelVersion = "stable";
        
      };

    };

  };
}
