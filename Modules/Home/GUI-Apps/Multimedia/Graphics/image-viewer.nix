# Image Viewer
#
# Provides:
#   - Installs a chosen image viewer application
#
# Notes:
#   - Defaults to Gwenview
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.image-viewer;
in
{
  options.nyx-module.home.image-viewer = {
    enable = lib.mkEnableOption "Enable image viewer (home module)";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.gwenview;
      example = pkgs.feh;
      description = "Image viewer package to install (e.g. gwenview, feh, imv).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
