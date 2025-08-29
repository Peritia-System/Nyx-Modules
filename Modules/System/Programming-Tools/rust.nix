{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.rust;
in
{
  options.nyx-module.system.rust = {
    enable = lib.mkEnableOption "Enable rust (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rust;
      description = "Package to install for rust.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
