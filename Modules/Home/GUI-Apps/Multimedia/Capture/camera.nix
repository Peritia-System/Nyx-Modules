# Camera GUI module
#
# Provides:
#   - Camera GUI package (default: snapshot)
#   - libcamera (always installed, required backend)
#
# Notes:
#   - You can override the GUI package with another (e.g., cheese, kamoso)
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.camera;
in {
  options.nyx-module.home.camera = {
    enable = lib.mkEnableOption "Enable camera (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.snapshot;
      example = pkgs.cheese;
      description = "Camera GUI package to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
      pkgs.libcamera
    ];
  };
}
