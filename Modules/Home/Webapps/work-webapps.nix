{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.work-webapps;
in
{
  options.nyx-module.home.work-webapps = {
    enable = lib.mkEnableOption "Enable work-webapps (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.work-webapps;
      description = "Package to install for work-webapps.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
