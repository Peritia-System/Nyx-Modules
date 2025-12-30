# Steam (System Module)
#
# Provides:
#   - Steam client
#   - Optional firewall openings for:
#       * Remote Play
#       * Source Dedicated Server
#       * Local Network Game Transfers
#   - ProtonUp tool for managing Proton versions
#
# Options:
#   - enable                   → Enable Steam system module
#   - openFirewall.remotePlay  → Open firewall for Remote Play
#   - openFirewall.dedicatedServer → Open firewall for Source Dedicated Server
#   - openFirewall.localNetworkGameTransfers → Open firewall for LAN transfers
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.steam;
in {
  options.nyx-module.system.steam = {
    enable = lib.mkEnableOption "Enable Steam (system module)";

    openFirewall = {
      remotePlay = lib.mkEnableOption "Open firewall for Steam Remote Play";
      dedicatedServer = lib.mkEnableOption "Open firewall for Source Dedicated Server";
      localNetworkGameTransfers = lib.mkEnableOption "Open firewall for Steam Local Network Game Transfers";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = cfg.openFirewall.remotePlay;
      dedicatedServer.openFirewall = cfg.openFirewall.dedicatedServer;
      localNetworkGameTransfers.openFirewall = cfg.openFirewall.localNetworkGameTransfers;
    };

    environment.systemPackages = with pkgs; [
      protonup-ng
    ];
  };
}
