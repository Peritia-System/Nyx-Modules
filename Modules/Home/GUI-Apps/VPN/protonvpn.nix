{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.protonvpn;
in
{
  options.nyx-module.home.protonvpn = {
    enable = lib.mkEnableOption "Enable protonvpn (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.protonvpn;
      description = "Package to install for protonvpn.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
