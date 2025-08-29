{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.openssh;
in
{
  options.nyx-module.system.openssh = {
    enable = lib.mkEnableOption "Enable openssh (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.openssh;
      description = "Package to install for openssh.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
