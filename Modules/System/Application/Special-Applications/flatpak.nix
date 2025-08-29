{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.flatpak;
in
{
  options.nyx-module.system.flatpak = {
    enable = lib.mkEnableOption "Enable flatpak (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.flatpak;
      description = "Package to install for flatpak.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
