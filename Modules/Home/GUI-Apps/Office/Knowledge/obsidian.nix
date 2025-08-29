{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.obsidian;
in
{
  options.nyx-module.home.obsidian = {
    enable = lib.mkEnableOption "Enable obsidian (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.obsidian;
      description = "Package to install for obsidian.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
