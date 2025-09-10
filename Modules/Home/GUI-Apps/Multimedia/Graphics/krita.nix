# Krita (Digital Painting Software)
#
# Provides:
#   - Krita package (open-source digital painting and illustration software)
#
# Notes:
#   - Installed via home.packages
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.krita;
in
{
  options.nyx-module.home.krita = {
    enable = lib.mkEnableOption "Enable Krita (home) module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      krita
    ];
  };
}
