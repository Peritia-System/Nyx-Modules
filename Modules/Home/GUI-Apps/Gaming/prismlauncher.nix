# PrismLauncher (Home Module)
#
# Provides:
#   - PrismLauncher (Minecraft launcher)
#   - Optional inclusion of ffmpeg (some mods require it)
#   - Configurable list of JDKs (for modpacks that need specific versions)
#
# Options:
#   - enable       → Enable PrismLauncher
#   - includeFfmpeg→ Include ffmpeg for mods
#   - jdks         → List of Java runtimes for PrismLauncher
#
# Notes:
#   - Installed via home.packages
#   - JDKs are added to PATH so PrismLauncher can discover them
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.prismlauncher;
in
{
  options.nyx-module.home.prismlauncher = {
    enable = lib.mkEnableOption "Enable PrismLauncher (Minecraft launcher)";

    includeFfmpeg = lib.mkEnableOption "Include ffmpeg for mods that require it";

    jdks = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ pkgs.jdk17 ];
      example = [ pkgs.jdk8 pkgs.jdk17 pkgs.jdk21 ];
      description = "List of Java runtimes to make available for PrismLauncher.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      [ pkgs.prismlauncher ]
      ++ lib.optionals cfg.includeFfmpeg [ pkgs.ffmpeg ]
      ++ cfg.jdks;
  };
}
