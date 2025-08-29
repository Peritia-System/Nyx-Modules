{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.all-grub;
in
{
  options.nyx-module.system.all-grub = {
    enable = lib.mkEnableOption "Enable all-grub (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.all-grub;
      description = "Package to install for all-grub.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
