# Zsh (System Module)
#
# Provides:
#   - Zsh shell
#   - oh-my-zsh integration
#   - Theme + plugins support
#
# Options:
#   - enable   → Enable Zsh system module
#   - ohMyZsh  → Enable oh-my-zsh integration
#   - theme    → oh-my-zsh theme (default: "xiong-chiamiov-plus")
#   - plugins  → List of oh-my-zsh plugins (default: [ "git" ])
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.zsh;
in
{
  options.nyx-module.system.zsh = {
    enable = lib.mkEnableOption "Enable Zsh (system module)";

    ohMyZsh = lib.mkEnableOption "Enable oh-my-zsh integration";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "xiong-chiamiov-plus";
      description = "oh-my-zsh theme to use.";
    };

    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "git" ];
      description = "List of oh-my-zsh plugins to enable.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      ohMyZsh = lib.mkIf cfg.ohMyZsh {
        enable = true;
        theme = cfg.theme;
        plugins = cfg.plugins;
      };
    };

    # Add zsh to available shells
    environment.shells = with pkgs; [ zsh ];
  };
}
