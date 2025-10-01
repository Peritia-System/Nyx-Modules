{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./flatpak.nix
    ./wireshark.nix
    ./gpg.nix
    ./gparted.nix
    ./packettracer.nix
  ];
}
