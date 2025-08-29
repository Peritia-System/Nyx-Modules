{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.vm;
in
{
  options.nyx-module.system.vm = {
    enable = lib.mkEnableOption "Enable vm (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.vm;
      description = "Package to install for vm.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
