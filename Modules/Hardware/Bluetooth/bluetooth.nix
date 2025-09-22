{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.hardware.bluetooth;
in {
  options.nyx-module.hardware.bluetooth = {
    enable = lib.mkEnableOption "Enable the system Bluetooth module";
  };

  config = lib.mkIf cfg.enable {
    # Enable Bluetooth support
    hardware.bluetooth = {
      enable = true; # Enable Bluetooth service
      powerOnBoot = true; # Power up the controller at boot
    };

    # Ensure firmware is available (needed for devices like Intel AX200)
    hardware.enableAllFirmware = true;
    hardware.firmware = [pkgs.linux-firmware];
  };
}
