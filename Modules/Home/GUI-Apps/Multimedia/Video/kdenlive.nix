{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.kdenlive;
in
{
  options.nyx-module.home.kdenlive = {
    enable = lib.mkEnableOption "Enable kdenlive (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kdenlive;
      description = "Package to install for kdenlive.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
