# GParted (System Module)
#
# Provides:
#   - GParted installation (GUI partition editor)
#
# Options:
#   - enable -> Enable GParted system module
#
{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.gparted;
in {
  options.nyx-module.system.gparted = {
    enable = lib.mkEnableOption "Enable GParted (system module)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gparted
    ];
  };
}
