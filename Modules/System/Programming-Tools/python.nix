{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.python;
in
{
  options.nyx-module.system.python = {
    enable = lib.mkEnableOption "Enable python (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python;
      description = "Package to install for python.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
