# Obsidian (note-taking / PKM app)
#
# Provides:
#   - Obsidian package via home.packages
#
# Notes:
#   - Consider adding theming support later
#     (e.g., https://github.com/jackiejude/obsidian-temple-os)
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.obsidian;
in {
  options.nyx-module.home.obsidian = {
    enable = lib.mkEnableOption "Enable Obsidian (home module)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.obsidian];
  };
}
