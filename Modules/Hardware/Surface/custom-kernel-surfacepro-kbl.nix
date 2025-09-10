# Custom Kernel Module for Microsoft Surface Pro (Kaby Lake / i5-7300U)
#
# Requires:
#   - inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
#
# Notes:
#   - Estimated kernel build time: ~4h30m
#
{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.hardware.Custom-Kernel.SurfacePro-KabyLake;
in
{
  options.nyx-module.hardware.Custom-Kernel.SurfacePro-KabyLake = {
    enable = lib.mkEnableOption "Enable Custom Surface Pro (Kaby Lake) kernel module";
    kernelVersion = lib.mkOption {
      type = lib.types.enum [ "stable" "longtime" ];
      default = "stable";
      description = "Choose which kernel version nixos-hardware will build for Surface Pro.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Ensure nixos-hardware Surface Pro module is imported
    assertions = [
      {
        assertion = config ? hardware.microsoft-surface;
        message = ''
          The module `nyx-module.hardware.Custom-Kernel.SurfacePro-KabyLake` requires
          `inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel`
          to be imported into your configuration.
        '';
      }
    ];

    # Pick kernel version for Surface hardware support
    hardware.microsoft-surface.kernelVersion = cfg.kernelVersion;
    # boot.kernelPackages = pkgs.linuxPackages_6_6; # normally set by nixos-hardware

    # Extra kernel modules
    boot.kernelModules = [ "hid-microsoft" "battery" "ac" ];

    # Initrd modules — required for Surface hardware to function
    boot.initrd.kernelModules = [
      # Surface Aggregator Module (SAM): buttons, sensors, keyboard
      "surface_aggregator"
      "surface_aggregator_registry"
      "surface_aggregator_hub"
      "surface_hid_core"
      "surface_hid"

      # Intel Low Power Subsystem (keyboard, I2C, etc.)
      "intel_lpss"
      "intel_lpss_pci"
      "8250_dw"
    ];

    environment.systemPackages = with pkgs; [
      #for camera
      libcamera

      # for Battery 
      tlp
      upower
      acpi
    ];

    # IPTSd not required — touchscreen and pen work via HID
    services.iptsd.enable = lib.mkForce false;

    # Optional: reduce display flickering
    # boot.kernelParams = [ "i915.enable_psr=0" ];

    # Optional: blacklist problematic modules
    # boot.blacklistedKernelModules = [ "surface_gpe" ];

    # Thermald for thermal management
    services.thermald = {
      enable = true;
      configFile = ./thermal-conf.xml;
      # Example: extra options if needed
      # extraOptions = [
      #   "--adaptive"
      #   "--max-temperature=65"
      # ];
    };

    # Optional: CPU power management tuning
    # powerManagement.cpuFreqGovernor = "powersave"; # or "ondemand", "performance"

    # Optional: disable Intel Turbo Boost if overheating persists
    # systemd.tmpfiles.rules = [
    #   "w /sys/devices/system/cpu/intel_pstate/no_turbo - - - - 1"
    # ];
  };
}
