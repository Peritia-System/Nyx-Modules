{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.office-apps;
in
{
  options.nyx-module.home.office-apps = {
    enable = lib.mkEnableOption "Enable office-apps (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.office-apps;
      description = "Package to install for office-apps.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
