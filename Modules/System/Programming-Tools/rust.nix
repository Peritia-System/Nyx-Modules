# Rust (System Module)
#
# Provides:
#   - Rust compiler (rustc)
#   - Cargo (Rust package manager & build system)
#
# Options:
#   - enable → Enable Rust system module
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.rust;
in {
  options.nyx-module.system.rust = {
    enable = lib.mkEnableOption "Enable Rust (system module)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rustc
      cargo
    ];
  };
}
