# Spotify (music streaming client)
#
# Provides:
#   - Spotify package (default)
#   - Optional override to install a different package
#
# Notes:
#   - Installs into home.packages
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.spotify;
in
{
  options.nyx-module.home.spotify = {
    enable = lib.mkEnableOption "Enable Spotify (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.spotify;
      example = pkgs.ncspot;
      description = ''
        Package to install for Spotify support.
        Defaults to the official `pkgs.spotify`, but you can override with
        `pkgs.ncspot`, `pkgs.spotifyd`, or similar alternatives.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
