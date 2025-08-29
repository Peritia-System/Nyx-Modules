{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.vscodium;
in
{
  options.nyx-module.home.vscodium = {
    enable = lib.mkEnableOption "Enable vscodium (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.vscodium;
      description = "Package to install for vscodium.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
