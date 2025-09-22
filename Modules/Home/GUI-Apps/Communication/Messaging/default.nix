{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./signal-desktop.nix
    ./vesktop.nix
  ];
}
