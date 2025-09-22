# Ruby (System Module)
#
# Provides:
#   - Ruby (standard interpreter)
#   - JRuby (Ruby on the JVM)
#   - Bundler (Ruby package manager, optional)
#
# Options:
#   - enable   → Enable Ruby system module (default: false)
#   - bundler  → Install Bundler alongside Ruby (default: follows `enable`)
#
# Examples:
#   nyx-module.system.ruby.enable = true;
#   nyx-module.system.ruby.bundler = false; # disable Bundler explicitly
#
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyx-module.system.ruby;
in {
  options.nyx-module.system.ruby = {
    enable = lib.mkEnableOption "Enable Ruby (system module)";

    bundler = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable; # follows Ruby enable by default
      description = ''
        Install Bundler with Ruby.
        Defaults to the same value as `enable`.
      '';
      example = true;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        ruby
        jruby
      ]
      ++ lib.optional cfg.bundler bundler;
  };
}
