{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.zsh;
in
{
  options.nyx-module.system.zsh = {
    enable = lib.mkEnableOption "Enable zsh (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zsh;
      description = "Package to install for zsh.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
