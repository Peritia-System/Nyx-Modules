{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.kde;
in
{
  options.nyx-module.system.kde = {
    enable = lib.mkEnableOption "Enable kde (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kde;
      description = "Package to install for kde.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
