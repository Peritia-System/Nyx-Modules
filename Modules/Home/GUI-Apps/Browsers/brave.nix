{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.brave;
in
{
  options.nyx-module.home.brave = {
    enable = lib.mkEnableOption "Enable brave (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.brave;
      description = "Package to install for brave.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
