{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.bluetooth;
in
{
  options.nyx-module.system.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.bluetooth;
      description = "Package to install for bluetooth.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
