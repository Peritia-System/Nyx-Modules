# Podman (System Module)
#
# Provides:
#   - Podman runtime and CLI
#   - Podman Compose
#   - User access via `podman` group
#
# Options:
#   - enable   → Enable Podman system module
#   - username → User to add to the podman group
#
# Notes:
#   - Adds podman + podman-compose to system packages
#   - Enables D-Bus socket activation for Podman
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.podman;
in {
  options.nyx-module.system.podman = {
    enable = lib.mkEnableOption "Enable Podman (system module)";

    username = lib.mkOption {
      type = lib.types.str;
      example = "alice";
      description = "User to add to the podman group.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman.enable = true;

    users.users.${cfg.username}.extraGroups = ["podman"];

    environment.systemPackages = with pkgs; [
      podman
      podman-compose
    ];

    # Optional: enable Podman socket activation
    services.dbus.packages = [pkgs.podman];

    assertions = [
      {
        assertion = cfg.username != "";
        message = "nyx-module.system.podman.username must be set to a valid user.";
      }
    ];
  };
}
