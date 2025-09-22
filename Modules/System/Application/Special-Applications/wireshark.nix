# Wireshark (System Module)
#
# Provides:
#   - Wireshark installation
#   - Proper dumpcap permissions
#   - Adds user to `wireshark` group
#
# Options:
#   - enable   → Enable Wireshark system module
#   - username → User to add to the wireshark group (required)
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.wireshark;
in {
  options.nyx-module.system.wireshark = {
    enable = lib.mkEnableOption "Enable Wireshark (system module)";

    username = lib.mkOption {
      type = lib.types.str;
      example = "alice";
      description = "User to add to the wireshark group.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.wireshark];

    programs.wireshark = {
      enable = true; # Installs wireshark + sets dumpcap caps
      package = pkgs.wireshark;
    };

    # Add user to wireshark group
    users.users.${cfg.username}.extraGroups = ["wireshark"];

    assertions = [
      {
        assertion = cfg.username != "";
        message = "nyx-module.system.wireshark.username must be set to a valid user.";
      }
    ];
  };
}
