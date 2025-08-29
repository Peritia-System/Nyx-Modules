{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.c-compiler;
in
{
  options.nyx-module.system.c-compiler = {
    enable = lib.mkEnableOption "Enable c-compiler (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.c-compiler;
      description = "Package to install for c-compiler.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
