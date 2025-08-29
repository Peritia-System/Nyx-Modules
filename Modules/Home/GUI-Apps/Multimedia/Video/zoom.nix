{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.zoom;
in
{
  options.nyx-module.home.zoom = {
    enable = lib.mkEnableOption "Enable zoom (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zoom;
      description = "Package to install for zoom.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
