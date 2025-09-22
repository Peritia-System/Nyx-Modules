# Go (System Module)
#
# Provides:
#   - Go programming language toolchain
#
# Options:
#   - enable → Enable Go system module
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.go;
in {
  options.nyx-module.system.go = {
    enable = lib.mkEnableOption "Enable Go (system module)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      go
    ];
  };
}
