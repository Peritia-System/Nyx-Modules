{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.minegrub;
in
{
  options.nyx-module.system.minegrub = {
    enable = lib.mkEnableOption "Enable minegrub (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.minegrub;
      description = "Package to install for minegrub.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
