{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.printer-scan;
in
{
  options.nyx-module.home.printer-scan = {
    enable = lib.mkEnableOption "Enable printer-scan (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.printer-scan;
      description = "Package to install for printer-scan.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
