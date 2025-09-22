# Python (System Module)
#
# Provides:
#   - Python 3 interpreter
#   - Pip (package manager)
#
# Options:
#   - enable → Enable Python system module
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.python;
in {
  options.nyx-module.system.python = {
    enable = lib.mkEnableOption "Enable Python (system module)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
      python3Packages.pip
    ];
  };
}
