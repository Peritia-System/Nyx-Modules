{ config, nixDirectory, pkgs, inputs, ... }:

{
  ################################################################
  # Module Imports
  ################################################################
  imports = [
    inputs.nyx-modules.homeManagerModules.default
  ];

  ################################################################
  # Nyx Modules
  ################################################################
  nyx-module.home = {

    ################################################################
    # Web Browsers
    ################################################################
    brave = {
      enable = true;
      extensions = {
        enable   = true;
        standard = true;   # uBlock, Proton Pass, Proton VPN
        extra    = [];     # Additional extension IDs
      };
    };

    ################################################################
    # Messaging
    ################################################################
    signal-desktop.enable = true;
    vesktop.enable        = true;
    zoom.enable           = false;

    ################################################################
    # Remote Support
    ################################################################
    rustdesk.enable       = false;

    ################################################################
    # Development
    ################################################################
    vscodium = {
      enable = true;
      extensions = {
        enable   = true;
        standard = true;
        extra    = [];
      };
    };

    ################################################################
    # Gaming
    ################################################################
    classic-game-collection.enable = true;
    prismlauncher.enable          = true;

    ################################################################
    # Audio / Visual Utilities
    ################################################################
    cava.enable       = false;
    spotify.enable    = true;
    camera.enable     = true;

    image-viewer = {
      enable  = true;
      package = pkgs.gwenview;
    };

    krita.enable      = true;
    kdenlive.enable   = true;

    video-player = {
      enable   = true;
      packages = [ pkgs.vlc pkgs.mpv ];
    };

    ################################################################
    # Office
    ################################################################
    obsidian.enable    = true;
    libreoffice.enable = true;
    pdf-viewer.enable  = true;
    printer.enable     = true;
    thunderbird.enable = true;

    ################################################################
    # VPN
    ################################################################
    protonvpn.enable = true;

    ################################################################
    # Shell / CLI Tools
    ################################################################
    cli-tools = {
      enable = true;
      extra   = [ pkgs.ripgrep pkgs.htop ];
    };

    zsh.enable = true;

    ################################################################
    # Webapps
    ################################################################
    private-webapps = {
      enable   = true;
      browser  = pkgs.chromium;
      whatsapp.enable = true;
    };

    work-webapps = {
      enable   = true;
      browser  = pkgs.chromium;
      slack.enable    = false;
      teams.enable    = false;
      outlook.enable  = true;
      entra.enable    = false;
    };
  };
# note this is not all Nyx-Module can do.

# other home.nix configurations

}
