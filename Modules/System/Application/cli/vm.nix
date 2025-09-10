# VM (System Module)
#
# Provides:
#   - QEMU/KVM virtualization via libvirt
#   - virt-manager GUI
#   - User access via libvirtd and kvm groups
#   - Spice, dnsmasq, and bridge-utils for networking and display
#
# Options:
#   - enable   → Enable VM system module
#   - username → User to add to virtualization groups (required)
#
# Notes:
#   - QEMU runs as root by default (can be adjusted)
#   - virt-manager GUI is enabled automatically
#   - Only generic "kvm" kernel module is forced (host picks intel/amd)
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.vm;
in
{
  options.nyx-module.system.vm = {
    enable = lib.mkEnableOption "Enable VM (system module)";

    username = lib.mkOption {
      type = lib.types.str;
      example = "alice";
      description = "User to add to virtualization groups.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
      spice-gtk
      dnsmasq
      bridge-utils
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_full;
        runAsRoot = true;
      };
    };

    # Add user to groups
    users.users.${cfg.username}.extraGroups = [ "libvirtd" "kvm" ];

    # Enable kernel modules for virtualization
    boot.kernelModules = [ "kvm" ];

    # Enable GUI management tool
    programs.virt-manager.enable = true;

    assertions = [
      {
        assertion = cfg.username != "";
        message = "nyx-module.system.vm.username must be set to a valid user.";
      }
    ];
  };
}
