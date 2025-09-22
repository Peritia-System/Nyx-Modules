# Printer GUI (scanning/printing tools)
#
# Provides:
#   - Configurable GUI package for printing/scanning via home.packages
#
# Notes:
#   - Default is `simple-scan` (GNOME Document Scanner)
#   - Can be overridden with another package such as `system-config-printer`
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.printer;
in {
  options.nyx-module.home.printer = {
    enable = lib.mkEnableOption "Enable printer GUI (home module)";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.simple-scan;
      example = pkgs.system-config-printer;
      description = "Printer/scanner GUI package to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
