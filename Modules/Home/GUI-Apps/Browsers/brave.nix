# Brave Browser (Home Module)
#
# Provides:
#   - Brave browser package
#   - Optional standard and custom extension sets
#
# Options:
#   - enable             → Enable Brave browser
#   - extensions.enable  → Enable Brave extensions
#   - extensions.standard→ Enable default extension set of extensions
#   - extensions.extra   → Extra extension IDs to install
#
# Notes:
#   - Default extensions include uBlock Origin, Proton Pass, Proton VPN
#   - Extra extensions must be specified by Chrome Web Store ID
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.brave;
in
{
  options.nyx-module.home.brave = {
    enable = lib.mkEnableOption "Enable Brave (home module)";

    extensions = {
      enable = lib.mkEnableOption "Enable Brave extensions support";
      standard = lib.mkEnableOption "Enable default set of extensions (uBlock, Proton Pass, Proton VPN)";
      extra = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        example = [ "abcdefghijklmnop" "qrstuvwxyz123456" ];
        description = "List of additional Brave extension IDs to install.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.brave = {
      enable = true;
      package = pkgs.brave;

      extensions = lib.optionals cfg.extensions.enable (
        (lib.optionals cfg.extensions.standard [
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
          { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # Proton Pass
          { id = "jplgfhpmjnbigmhklmmbgecoobifkmpa"; } # Proton VPN
        ]) ++
        (map (id: { inherit id; }) cfg.extensions.extra)
      );

      commandLineArgs = [
        "--disable-features=AutofillSavePaymentMethods"
        "--disable-features=PasswordManagerOnboarding"
        "--disable-features=AutofillEnableAccountWalletStorage"
      ];
    };
  };
}
