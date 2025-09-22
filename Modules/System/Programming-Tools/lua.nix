# Lua (System Module)
#
# Provides:
#   - Lua (standard interpreter)
#   - LuaJIT (Just-In-Time compiler)
#
# Options:
#   - enable → Enable Lua system module
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.lua;
in {
  options.nyx-module.system.lua = {
    enable = lib.mkEnableOption "Enable Lua (system module)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lua
      luajit
    ];
  };
}
