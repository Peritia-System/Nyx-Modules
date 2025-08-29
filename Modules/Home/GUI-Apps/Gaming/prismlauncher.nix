{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.prismlauncher;
in
{
  options.nyx-module.home.prismlauncher = {
    enable = lib.mkEnableOption "Enable prismlauncher (home) module";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.prismlauncher;
      description = "Package to install for prismlauncher.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
