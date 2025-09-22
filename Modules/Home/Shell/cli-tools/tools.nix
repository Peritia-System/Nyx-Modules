# CLI Tools (Home Module)
#
# Provides:
#   - A curated set of command-line utilities in user’s environment
#   - Examples: fastfetch, hyfetch, bat, fzf, tree, lsd, tmux
#
# Options:
#   - enable → Enable CLI tools collection
#   - extra  → List of extra packages to install
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.cli-tools;
in {
  options.nyx-module.home.cli-tools = {
    enable = lib.mkEnableOption "Enable CLI tools (home module)";

    extra = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      example = [pkgs.ripgrep pkgs.htop];
      description = "Extra CLI tools to install in addition to the defaults.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        fastfetch
        hyfetch
        bat
        fzf
        tree
        lsd
        tmux
      ]
      ++ cfg.extra;
  };
}
