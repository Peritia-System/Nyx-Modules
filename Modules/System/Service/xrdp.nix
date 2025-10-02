# nyx-module/system/service/xrdp.nix
#
# XRDP (System Module)
#
# Provides:
#   - XRDP remote desktop service
#   - Desktop environment selection for RDP sessions
#   - Optional automatic firewall rule opening
#
# Options:
#   - enable              -> Enable XRDP system module
#   - defaultWindowManager -> Select Plasma / XFCE / GNOME for remote sessions
#   - port                -> TCP port for XRDP (default: 3389)
#   - openFirewall        -> Open firewall for XRDP port (default: true)
#

{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.nyx-module.system.service.xrdp;
in
{
  options.nyx-module.system.service.xrdp = {
    enable = mkEnableOption "XRDP remote desktop service";

    defaultWindowManager = mkOption {
      type = types.enum [ "plasma" "xfce" "gnome" ];
      example = "xfce";
      description = ''
        Desktop environment to start for XRDP sessions.
      '';
    };

    port = mkOption {
      type = types.port;
      default = 3389;
      description = "TCP port for XRDP to listen on.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = ''
        If true, open the system firewall for the XRDP TCP port.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      defaultWindowManager = cfg.defaultWindowManager;
      port = cfg.port;
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}
