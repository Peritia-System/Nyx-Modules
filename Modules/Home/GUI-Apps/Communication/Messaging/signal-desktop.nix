# Signal Desktop (Home Module)
#
# Provides:
#   - Signal Desktop secure messaging client
#
# Options:
#   - enable  → Enable Signal Desktop
#   - package → Override package (default: pkgs.signal-desktop)
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.signal-desktop;
in
{
  options.nyx-module.home.signal-desktop = {
    enable = lib.mkEnableOption "Enable signal-desktop (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.signal-desktop;
      description = "Package to install for signal-desktop.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
