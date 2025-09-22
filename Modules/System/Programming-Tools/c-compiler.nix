# C Compiler (System Module)
#
# Provides:
#   - GCC (C/C++)
#   - Clang (alternative C/C++)
#   - Mono (C#)
#
# Options:
#   - enable → Enable C compiler toolchain
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.c-compiler;
in {
  options.nyx-module.system.c-compiler = {
    enable = lib.mkEnableOption "Enable C compiler (system module)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc # C & C++
      clang # alt C/C++
      mono # C#
    ];
  };
}
