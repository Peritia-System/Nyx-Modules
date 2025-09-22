{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./flatpak.nix
    ./wireshark.nix
  ];
}
