# VSCodium (Home Module)
#
# Provides:
#   - VSCodium editor (open-source build of VS Code)
#   - Optional extension sets
#
# Options:
#   - enable             → Enable VSCodium
#   - extensions.enable  → Enable extensions
#   - extensions.standard→ Enable standard extensions
#   - extensions.extra   → Extra extensions to install
#
# Notes:
#   - Some Microsoft extensions may be broken (e.g., ms-python.python)
#


{ config, pkgs, lib, ... }:

let
  cfg = config.nyx-module.home.vscodium;
in
{
  options.nyx-module.home.vscodium = {
    enable = lib.mkEnableOption "Enable VSCodium with extensions";

    extensions = {
      enable = lib.mkEnableOption "Enable VSCodium extensions";

      standard = lib.mkEnableOption "Enable standard extensions";

      extra = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
        example = [ pkgs.vscode-extensions.ms-python.python ];
        description = "List of extra VSCodium extensions to install.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles.default.extensions =
        lib.optionals cfg.extensions.enable (
          (lib.optionals cfg.extensions.standard (with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
            jnoortheen.nix-ide
            ms-azuretools.vscode-docker
            # ms-python.python # currently broken (pygls failure)
          ]))
          ++ cfg.extensions.extra
        );
    };
  };
}
