# Video Player(s)
#
# Provides:
#   - Installs one or more chosen video/media players
#
# Notes:
#   - Defaults to [ vlc ]
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.video-player;
in {
  options.nyx-module.home.video-player = {
    enable = lib.mkEnableOption "Enable video players (home module)";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [pkgs.vlc];
      example = [pkgs.vlc pkgs.mpv pkgs.celluloid];
      description = "List of video/media players to install (e.g. vlc, mpv, celluloid).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = cfg.packages;
  };
}
##########
# Example
##########
# nyx-module.home.video-player = {
#   enable = true;
#   packages = [ pkgs.vlc pkgs.mpv ];
# };

