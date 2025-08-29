{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.go;
in
{
  options.nyx-module.system.go = {
    enable = lib.mkEnableOption "Enable go (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.go;
      description = "Package to install for go.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
