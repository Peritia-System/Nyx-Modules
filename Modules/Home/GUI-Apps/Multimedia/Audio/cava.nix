# CAVA (Home Module)
#
# Provides:
#   - CAVA audio visualizer
#   - Declarative configuration via Nix
#   - Support for structured settings or raw config override
#
# Options:
#   - enable     → Enable CAVA (home module)
#   - settings   → Declarative structured configuration (default: ALSA, 60 FPS, basic colors)
#   - configText → Raw configuration text (overrides settings if set)
#
# Notes:
#   - Writes config to ~/.config/cava/config
#   - If configText is set, settings are ignored
#
# Example:
#   nyx-module.home.cava = {
#     enable = true;
#     settings.general.framerate = 120;
#     settings.input.method = "pulse";
#   };

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.cava;
in
{
  options.nyx-module.home.cava = {
    enable = lib.mkEnableOption "Enable CAVA (home) module";

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {
        general.framerate = 60;
        input.method = "alsa";
        smoothing.noise_reduction = 88;
        color = {
          background = "#000000";
          foreground = "#FFFFFF";
        };
      };
      description = ''
        Declarative CAVA settings, written to `~/.config/cava/config`.  
        Ignored if `configText` is set.
      '';
      example = {
        general.framerate = 30;
        input.method = "pulseaudio";
        color.foreground = "#00FF00";
      };
    };

    configText = lib.mkOption {
      type = lib.types.nullOr lib.types.lines;
      default = null;
      description = ''
        Raw CAVA configuration file contents.  
        If set, overrides `settings` and is written directly to `~/.config/cava/config`.
      '';
      example = ''
        [general]
        framerate = 120
        [input]
        method = pulse
        '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.cava = {
      enable = true;
      package = pkgs.cava;


      settings = lib.mkIf (cfg.configText == null) cfg.settings;
    };


    xdg.configFile."cava/config" = lib.mkIf (cfg.configText != null) {
      text = cfg.configText;
    };
  };
}
