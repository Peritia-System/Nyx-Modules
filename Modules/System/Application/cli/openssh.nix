# OpenSSH (System Module)
#
# Provides:
#   - OpenSSH server (sshd) service
#
# Options:
#   - enable          → Enable OpenSSH system module
#   - passwordAuth    → Allow password authentication (default: false)
#   - permitRootLogin → Permit root login (default: "no")
#
# Notes:
#   - By default, password authentication is disabled for better security
#   - Root login is disabled unless explicitly enabled
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.openssh;
in {
  options.nyx-module.system.openssh = {
    enable = lib.mkEnableOption "Enable OpenSSH (system module)";

    passwordAuth = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to allow password authentication.";
    };

    permitRootLogin = lib.mkOption {
      type = lib.types.str;
      default = "no";
      example = "prohibit-password";
      description = "Whether to permit root login via SSH.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = cfg.passwordAuth;
        PermitRootLogin = cfg.permitRootLogin;
      };
    };
  };
}
