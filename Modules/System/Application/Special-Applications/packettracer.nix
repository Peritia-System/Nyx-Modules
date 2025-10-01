# Nyx Packet Tracer Module
#
# This NixOS module installs Cisco Packet Tracer declaratively.
#
# Supported input formats for `source`:
#   - /nix/store/<hash>-file.deb          (preferred, pure and cached)
#   - "https://example.com/file.deb"      (requires `sha256`)
#   - ./relative/path/to/file.deb         (will be imported into the Nix store)
#
# Example:
#
#   nyx-module.system.packetTracer = {
#     enable = true;
#     source = ./Packet_Tracer822_amd64_signed.deb;
#   };
#
# Notes:
#   • If using a URL Cisco's official download links may not work without login
#     Thats why I recommend using a local path that you added into the store
#   • If using a local non-store absolute path (e.g. /home/user/file.deb),
#     you must first import it:
#
#         nix store add-path /home/user/file.deb
#
#     Then use the resulting /nix/store/... path instead.


{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nyx-module.system.packetTracer;

  isUrl = s: hasPrefix "http://" s || hasPrefix "https://" s;
  isAbsolute = s: hasPrefix "/" s;
  isNixStore = s: hasPrefix "/nix/store/" s;
  isRelative = s: hasPrefix "./" s;
  isPathType = v: builtins.isPath v;

  src =
    if isPathType cfg.source then
      cfg.source
    else if isUrl cfg.source then
      pkgs.fetchurl {
        url = cfg.source;
        sha256 = cfg.sha256;
      }
    else
      cfg.source;
in
{
  options.nyx-module.system.packetTracer = {
    enable = mkEnableOption "Cisco Packet Tracer installation";

    source = mkOption {
      type = with types; oneOf [ path str ];
      default = "";
      description = ''
        Allowed:
          /nix/store/<hash>-file.deb
          https://example.com/file.deb   (requires sha256)
          ./relative/path.deb
      '';
    };

    sha256 = mkOption {
      type = types.str;
      default = lib.fakeSha256;
      description = "SHA-256 for URL sources.";
    };
  };

  config = mkIf cfg.enable (mkIf (cfg.source != "") {

    assertions = [
      {
        assertion = cfg.source != "";
        message = "nyx-module.system.packetTracer.source must be set when packetTracer is enabled.";
      }
      {
        assertion = !(isAbsolute cfg.source && !isNixStore cfg.source);
        message = ''
          nyx-module.system.packetTracer.source points to a non-store absolute path:

            ${cfg.source}

          Pure evaluation cannot use /home, /tmp, /mnt, or other "normal" paths.
          It can only use /nix/store/... paths

          First import it into the Nix store:

            nix store add-path ${cfg.source}

          Then use the resulting /nix/store/... path instead.
        '';
      }
      {
        assertion = !(isUrl cfg.source && cfg.sha256 == lib.fakeSha256);
        message = "nyx-module.system.packetTracer.sha256 must be set when using a URL source.";
      }
    ];

    environment.systemPackages = [
      (pkgs.ciscoPacketTracer8.override { packetTracerSource = src; })
    ];
  });
}
