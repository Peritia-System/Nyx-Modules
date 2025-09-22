# Zoom (video conferencing client)
#
# Provides:
#   - Zoom package (default: pkgs.zoom-us)
#
# Options:
#   - `package`: override the package (e.g. pkgs.zoom)
#
# Notes:
#   - Installed via home.packages
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.zoom;
in {
  options.nyx-module.home.zoom = {
    enable = lib.mkEnableOption "Enable Zoom (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zoom-us;
      description = "Zoom package to install (e.g., pkgs.zoom-us).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
