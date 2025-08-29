{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.camera;
in
{
  options.nyx-module.home.camera = {
    enable = lib.mkEnableOption "Enable camera (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.camera;
      description = "Package to install for camera.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
