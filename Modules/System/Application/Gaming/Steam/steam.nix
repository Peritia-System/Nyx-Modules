{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.steam;
in
{
  options.nyx-module.system.steam = {
    enable = lib.mkEnableOption "Enable steam (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.steam;
      description = "Package to install for steam.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
