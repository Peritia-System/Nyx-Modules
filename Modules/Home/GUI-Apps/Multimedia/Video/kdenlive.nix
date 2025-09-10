# Kdenlive (video editor)
#
# Provides:
#   - Kdenlive video editor
#   - Installed via home.packages
#
# Notes:
#   - Package location depends on nixpkgs version:
#       * pkgs.kdePackages.kdenlive  (preferred, modern KDE split)
#       * pkgs.libsForQt5.kdenlive   (older releases, fallback)
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.kdenlive;
in
{
  options.nyx-module.home.kdenlive = {
    enable = lib.mkEnableOption "Enable Kdenlive (home) module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.kdePackages.kdenlive or pkgs.libsForQt5.kdenlive)
    ];
  };
}
