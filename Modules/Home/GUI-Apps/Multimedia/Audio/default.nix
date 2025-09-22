{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cava.nix
    ./spotify.nix
  ];
}
