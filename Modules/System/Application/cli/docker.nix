# Docker (System Module)
#
# Provides:
#   - Docker runtime and CLI
#   - Docker Compose
#   - User access via `docker` group
#   - Optional rootless mode and cgroup v2 support
#
# Options:
#   - enable       → Enable Docker system module
#   - username     → User to add to the docker group
#   - enableOnBoot → Start Docker service on boot (default: true)
#   - rootless     → Enable Docker rootless mode (disabled by default)
#
# Notes:
#   - Rootless mode is disabled by default
#   - Uses cgroup v2 for better resource management on modern kernels

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.docker;
in
{
  options.nyx-module.system.docker = {
    enable = lib.mkEnableOption "Enable Docker (system module)";

    username = lib.mkOption {
      type = lib.types.str;
      example = "alice";
      description = "User to add to the docker group.";
    };

    enableOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable Docker service on boot.";
    };

    rootless = lib.mkEnableOption "Enable rootless Docker mode";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = cfg.enableOnBoot;
      rootless.enable = cfg.rootless;
    };

    users.users.${cfg.username}.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];

    # Optional: Docker cgroup v2 (usually enabled by default in modern NixOS)
    boot.kernelParams = [ "cgroup_enable=memory" "cgroup_memory=1" ];


    assertions = [
      {
        assertion = cfg.username != "";
        message = "nyx-module.system.docker.username must be set to a valid user.";
      }
    ];
  };
}
