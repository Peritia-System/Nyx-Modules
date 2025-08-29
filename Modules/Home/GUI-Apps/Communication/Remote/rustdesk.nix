{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.rustdesk;
in
{
  options.nyx-module.home.rustdesk = {
    enable = lib.mkEnableOption "Enable rustdesk (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.rustdesk;
      description = "Package to install for rustdesk.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
