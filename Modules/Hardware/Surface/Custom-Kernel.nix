{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.system.Custom-Kernel;
in
{
  options.nyx-module.system.Custom-Kernel = {
    enable = lib.mkEnableOption "Enable Custom-Kernel (system) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.Custom-Kernel;
      description = "Package to install for Custom-Kernel.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
