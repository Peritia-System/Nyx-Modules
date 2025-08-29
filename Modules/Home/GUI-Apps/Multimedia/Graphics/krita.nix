{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.krita;
in
{
  options.nyx-module.home.krita = {
    enable = lib.mkEnableOption "Enable krita (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.krita;
      description = "Package to install for krita.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
