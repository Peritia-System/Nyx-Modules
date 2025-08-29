{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.standard-apps;
in
{
  options.nyx-module.home.standard-apps = {
    enable = lib.mkEnableOption "Enable standard-apps (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.standard-apps;
      description = "Package to install for standard-apps.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
