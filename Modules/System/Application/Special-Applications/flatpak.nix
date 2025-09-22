# Flatpak (System Module)
#
# Provides:
#   - Flatpak package manager
#   - Flatpak service integration
#   - XDG portals for sandboxed apps
#
# Options:
#   - enable → Enable Flatpak system module
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.flatpak;
in {
  options.nyx-module.system.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpak (system module)";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    # Flatpak apps need XDG portals for proper desktop integration
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk # For GTK desktops
        # xdg-desktop-portal-kde # Uncomment for KDE Plasma
      ];
    };

    # Optional explicit installation (not strictly needed)
    environment.systemPackages = [pkgs.flatpak];
  };
}
