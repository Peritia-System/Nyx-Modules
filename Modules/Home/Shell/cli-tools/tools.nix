{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.tools;
in
{
  options.nyx-module.home.tools = {
    enable = lib.mkEnableOption "Enable tools (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.tools;
      description = "Package to install for tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
