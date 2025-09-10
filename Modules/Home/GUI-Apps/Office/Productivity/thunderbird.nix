# Thunderbird (email client)
#
# Provides:
#   - Thunderbird package via home.packages
#
# Notes:
#   - Simple module, just adds Thunderbird to the user environment
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.thunderbird;
in
{
  options.nyx-module.home.thunderbird = {
    enable = lib.mkEnableOption "Enable Thunderbird (home module)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.thunderbird ];
  };
}
