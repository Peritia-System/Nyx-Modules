# RustDesk (Home Module)
#
# Provides:
#   - RustDesk remote desktop software (TeamViewer/AnyDesk alternative)
#
# Options:
#   - enable  → Enable RustDesk
#   - package → Override package (default: pkgs.rustdesk)
#
# Notes:
#   - Estimated build time: ~? Long....
#

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
       description = ''
        Package to install for RustDesk.
        You can override this if you want to pin a version or use a fork.
      '';
      example = "pkgs.rustdesk.overrideAttrs (old: { version = \"1.3.5\"; })";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
