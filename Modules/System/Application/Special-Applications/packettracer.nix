# Nyx Packet Tracer Module
#
# This NixOS module installs Cisco Packet Tracer declaratively.
#
# Supports multiple formats for `source`:
#
# 1. URL Mode (must start with http/https):
#      source = "http://example.com/PacketTracer.deb";
#      sha256 = "...";
#
# 2. Derivation / Path Mode (outputs from fetchzip, fetchgit, or /nix/store/...):
#      source = pkgs.fetchzip { ... };
#      source = /nix/store/<hash>-PacketTracer.deb;
#
# 3. Directory Mode (path or derivation pointing to a folder — auto-detects .deb):
#      source = /nix/store/<hash>-packettracer-src/;
#
# Example Usage:
#
#   nyx-module.system.packetTracer = {
#     enable = true;
#     source = "http://example.com/PacketTracer.deb";
#     sha256 = ".....";
#   };
#
#   nyx-module.system.packetTracer = {
#     enable = true;
#     source = pkgs.fetchzip {
#       url = "https://example.com/archivedPacketTracer.zip";
#       sha256 = "sha256-...";
#     };
#   };
#
#

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nyx-module.system.packetTracer;

  isUrl = s:
    builtins.isString s
    && (hasPrefix "http://" s || hasPrefix "https://" s);

  isPathString = s:
    builtins.isString s && hasPrefix "/" s;

  # Normalize `source` into something that can be given to PacketTracer override
  src =
    if isUrl cfg.source then
      pkgs.fetchurl {
        url = cfg.source;
        sha256 = cfg.sha256;
      }
    else if isDerivation cfg.source || builtins.isPath cfg.source || isPathString cfg.source then
      let
        # Convert to string path
        pathStr = toString cfg.source;
        # Read directory?
        entries = builtins.tryEval (builtins.readDir pathStr);
      in
        if entries.success then
          # Directory mode — auto-detect *.deb
          let
            files = builtins.attrNames entries.value;
            debs = builtins.filter (n: lib.hasSuffix ".deb" n) files;
          in
            if builtins.length debs == 1 then
              pathStr + "/" + builtins.elemAt debs 0
            else if builtins.length debs == 0 then
              (throw "nyx.packetTracer: No .deb found in directory ${pathStr}")
            else
              (throw "nyx.packetTracer: Multiple .deb files found in directory ${pathStr}")

        else
          # Probably a direct file
          pathStr
    else
      throw "nyx.packetTracer: Invalid source; must be URL, derivation, or path.";
in {
  options.nyx-module.system.packetTracer = {
    enable = mkEnableOption "Cisco Packet Tracer installation";

    source = mkOption {
      type = with types; oneOf [ str path ];
      default = "";
      description = ''
        Source of the Packet Tracer .deb file.

        Accepted:
          • "https://example.com/file.deb"   (requires sha256)
          • pkgs.fetchzip { ... }


        Checkout https://github.com/Peritia-System/Nyx-Modules/blob/main/Modules/System/Application/Special-Applications/packettracer.nix
      '';
    };

    sha256 = mkOption {
      type = types.str;
      default = "";
      description = "Required only when `source` is a URL.";
    };
  };

  config = mkIf cfg.enable (mkIf (cfg.source != "") {

    assertions = [
      {
        assertion = isUrl cfg.source || isDerivation cfg.source
          || builtins.isPath cfg.source || isPathString cfg.source;
        message = "source must be URL, derivation, or /nix/store path.";
      }
      {
        assertion = !(isUrl cfg.source && cfg.sha256 == "");
        message = "sha256 is required when source is a URL.";
      }
    ];

    environment.systemPackages = [
      (pkgs.ciscoPacketTracer8.override { packetTracerSource = src; })
    ];
  });
}
