# PDF Viewer / Scanner
#
# Provides:
#   - Install a chosen PDF or scanning GUI application
#
# Notes:
#   - Defaults to Okular
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.pdf-viewer;
in
{
  options.nyx-module.home.pdf-viewer = {
    enable = lib.mkEnableOption "Enable PDF (home module)";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kdePackages.okular;
      example = pkgs.evince;
      description = "PDF or scanning GUI package to install (e.g. Okular, Evince, Xournal++).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
