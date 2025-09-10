# Private Webapps
#
# Provides:
#   - Browser-based desktop entries for personal/private webapps
#   - Currently supported:
#       • WhatsApp
#
# Options:
#   - browser   → Selects which browser package to use (default: chromium)
#   - whatsapp  → Enable WhatsApp webapp launcher
#
# Notes:
#   - Uses --app mode to create minimal browser windows
#   - Additional services can be added following the same pattern

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.private-webapps;
in
{
  options.nyx-module.home.private-webapps = {
    enable = lib.mkEnableOption "Enable private webapps (home module)";

    browser = lib.mkOption {
      type = lib.types.package;
      default = pkgs.chromium;
      example = pkgs.firefox;
      description = "Browser package to use for private webapps.";
    };

    whatsapp.enable = lib.mkEnableOption "Enable WhatsApp webapp entry";
  };

  config = lib.mkIf cfg.enable {
    xdg.desktopEntries = lib.mkMerge [
      (lib.mkIf cfg.whatsapp.enable {
        whatsapp = {
          name = "WhatsApp";
          exec = "${cfg.browser}/bin/${cfg.browser.pname} --app=https://web.whatsapp.com/";
          icon = "WhatsApp";
          type = "Application";
        };
      })
    ];
  };
}
