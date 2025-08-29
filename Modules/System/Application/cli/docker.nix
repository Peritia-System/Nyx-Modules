{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.docker;
in
{
  options.nyx-module.system.docker = {
    enable = lib.mkEnableOption "Enable docker (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.docker;
      description = "Package to install for docker.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
