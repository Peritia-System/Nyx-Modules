# Work Webapps
#
# Provides:
#   - Browser-based desktop entries for work-related webapps
#   - Currently supported:
#       • Slack
#       • Microsoft Teams
#       • Outlook Web
#       • Microsoft Entra
#
# Options:
#   - browser  → Selects which browser package to use (default: chromium)
#   - slack    → Enable Slack webapp launcher
#   - teams    → Enable Teams webapp launcher
#   - outlook  → Enable Outlook webapp launcher
#   - entra    → Enable Entra webapp launcher
#
# Notes:
#   - Uses --app mode for minimal windows (like PWAs)
#   - Outlook entry uses a custom profile directory for isolation
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.home.work-webapps;
in {
  options.nyx-module.home.work-webapps = {
    enable = lib.mkEnableOption "Enable work webapps (home module)";

    browser = lib.mkOption {
      type = lib.types.package;
      default = pkgs.chromium;
      example = pkgs.firefox;
      description = "Browser package to use for private webapps.";
    };

    slack.enable = lib.mkEnableOption "Enable Slack webapp entry";
    teams.enable = lib.mkEnableOption "Enable Microsoft Teams webapp entry";
    outlook.enable = lib.mkEnableOption "Enable Outlook webapp entry";
    entra.enable = lib.mkEnableOption "Enable Microsoft Entra webapp entry";
  };

  config = lib.mkIf cfg.enable {
    xdg.desktopEntries = lib.mkMerge [
      (lib.mkIf cfg.slack.enable {
        slack = {
          name = "Slack";
          exec = "${cfg.browser}/bin/${cfg.browser.pname} --app=https://app.slack.com/client";
          icon = "slack";
          type = "Application";
        };
      })

      (lib.mkIf cfg.teams.enable {
        teams = {
          name = "Microsoft Teams";
          exec = "${cfg.browser}/bin/${cfg.browser.pname} --app=https://teams.microsoft.com";
          icon = "teams";
          type = "Application";
        };
      })

      (lib.mkIf cfg.outlook.enable {
        outlook = {
          name = "Outlook Web";
          exec = "${cfg.browser}/bin/${cfg.browser.pname} --user-data-dir=/home/${config.home.username}/.local/share/ice/profiles/Outlook4305 --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo";
          icon = "outlook";
          type = "Application";
        };
      })

      (lib.mkIf cfg.entra.enable {
        entra = {
          name = "Microsoft Entra";
          exec = "${cfg.browser}/bin/${cfg.browser.pname} --app=https://entra.microsoft.com";
          icon = "microsoft";
          type = "Application";
        };
      })
    ];
  };
}
