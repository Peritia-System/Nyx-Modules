{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.private-webapps;
in
{
  options.nyx-module.home.private-webapps = {
    enable = lib.mkEnableOption "Enable private-webapps (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.private-webapps;
      description = "Package to install for private-webapps.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
