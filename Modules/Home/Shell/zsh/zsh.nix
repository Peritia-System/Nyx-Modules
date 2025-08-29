{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.zsh;
in
{
  options.nyx-module.home.zsh = {
    enable = lib.mkEnableOption "Enable zsh (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zsh;
      description = "Package to install for zsh.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
