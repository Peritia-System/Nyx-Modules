{ config, lib, pkgs, ... }:

{
  nyx-module = {
    system = {
      docker = {
        enable = true;
        
        username = "alice";
        
        enableOnBoot = true;
        
        rootless = true;
        
      };

      openssh = {
        enable = true;
        
        passwordAuth = false;
        
        permitRootLogin = "no";
        
      };

      podman = {
        enable = true;
        
        username = "alice";
        
      };

      vm = {
        enable = true;
        
        username = "alice";
        
      };

      zsh = {
        enable = true;
        
        ohMyZsh = true;
        
        theme = "xiong-chiamiov-plus";
        
        plugins = [ "git" ];
        
      };

      steam = {
        enable = true;
        
        remotePlay = true;
        
        dedicatedServer = true;
        
        localNetworkGameTransfers = true;
        
      };

      flatpak = {
        enable = true;
        
      };

      wireshark = {
        enable = true;
        
        username = "alice";
        
      };

      c-compiler = {
        enable = true;
        
      };

      go = {
        enable = true;
        
      };

      lua = {
        enable = true;
        
      };

      python = {
        enable = true;
        
      };

      rust = {
        enable = true;
        
      };

    };

    home = {
      brave = {
        enable = true;
        
        enable = true;
        
        standard = true;
        
        extra = [];
        
      };

      signal-desktop = {
        enable = true;
        
        package = pkgs.signal-desktop;
        
      };

      vesktop = {
        enable = true;
        
        package = pkgs.vesktop;
        
      };

      rustdesk = {
        enable = true;
        
        package = pkgs.rustdesk;
        
      };

      vscodium = {
        enable = true;
        
        enable = true;
        
        standard = true;
        
        extra = [];
        
      };

      classic-game-collection = {
        enable = true;
        
      };

      prismlauncher = {
        enable = true;
        
        includeFfmpeg = true;
        
        jdks = [ pkgs.jdk17 ];
        
      };

      cava = {
        enable = true;
        
        settings =       default = {;
        
        configText = null;
        
      };

      spotify = {
        enable = true;
        
        package = pkgs.spotify;
        
      };

      camera = {
        enable = true;
        
        package = pkgs.snapshot;
        
      };

      image-viewer = {
        enable = true;
        
        package = pkgs.gwenview;
        
      };

      krita = {
        enable = true;
        
      };

      kdenlive = {
        enable = true;
        
      };

      video-player = {
        enable = true;
        
        packages = [ pkgs.vlc ];
        
      };

      zoom = {
        enable = true;
        
        package = pkgs.zoom-us;
        
      };

      obsidian = {
        enable = true;
        
      };

      libreoffice = {
        enable = true;
        
      };

      pdf-reader = {
        enable = true;
        
        package = pkgs.kdeApplications.okular;
        
      };

      printer-scan = {
        enable = true;
        
        package = pkgs.simple-scan;
        
      };

      thunderbird = {
        enable = true;
        
      };

      protonvpn = {
        enable = true;
        
      };

      tools = {
        enable = true;
        
        extra = [];
        
      };

      zsh = {
        enable = true;
        
      };

      private-webapps = {
        enable = true;
        
        browser = pkgs.chromium;
        
      };

      work-webapps = {
        enable = true;
        
        browser = pkgs.chromium;
        
      };

    };

    hardware = {
      bluetooth = {
        enable = true;
        
      };

      custom-kernel-surfacepro-kbl = {
        enable = true;
        
        kernelVersion = "stable";
        
      };

    };

  };
}
