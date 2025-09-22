# Vesktop (Home Module)
#
# Provides:
#   - Vesktop package (Discord client, Electron wrapper)
#
# Options:
#   - enable  → Enable Vesktop client
#   - package → Override package (default: pkgs.vesktop)
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.vesktop;
in {
  options.nyx-module.home.vesktop = {
    enable = lib.mkEnableOption "Enable vesktop (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.vesktop;
      description = "Package to install for vesktop.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
  };
}
