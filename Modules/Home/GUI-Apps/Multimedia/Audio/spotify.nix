{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.spotify;
in
{
  options.nyx-module.home.spotify = {
    enable = lib.mkEnableOption "Enable spotify (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.spotify;
      description = "Package to install for spotify.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
