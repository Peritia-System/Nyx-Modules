{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.classic-game-collection;
in
{
  options.nyx-module.home.classic-game-collection = {
    enable = lib.mkEnableOption "Enable classic-game-collection (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.classic-game-collection;
      description = "Package to install for classic-game-collection.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
