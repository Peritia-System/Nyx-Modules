{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.wireshark;
in
{
  options.nyx-module.system.wireshark = {
    enable = lib.mkEnableOption "Enable wireshark (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.wireshark;
      description = "Package to install for wireshark.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
