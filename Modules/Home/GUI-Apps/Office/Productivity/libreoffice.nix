# LibreOffice (office suite)
#
# Provides:
#   - LibreOffice package via home.packages
#
# Notes:
#   - Simple module, just adds LibreOffice to the user environment
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.libreoffice;
in {
  options.nyx-module.home.libreoffice = {
    enable = lib.mkEnableOption "Enable LibreOffice (home module)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.libreoffice];
  };
}
