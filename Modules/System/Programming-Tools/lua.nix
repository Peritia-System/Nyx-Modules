{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.lua;
in
{
  options.nyx-module.system.lua = {
    enable = lib.mkEnableOption "Enable lua (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.lua;
      description = "Package to install for lua.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
