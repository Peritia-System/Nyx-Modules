# ProtonVPN (Home Module)
#
# Provides:
#   - ProtonVPN GUI client
#
# Options:
#   - enable → Enable ProtonVPN client
#
# Notes:
#   - GUI only by default (CLI version available as pkgs.protonvpn-cli)
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.protonvpn;
in {
  options.nyx-module.home.protonvpn = {
    enable = lib.mkEnableOption "Enable ProtonVPN (home module)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      protonvpn-gui
    ];
  };
}
