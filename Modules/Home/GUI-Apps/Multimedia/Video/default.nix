{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./kdenlive.nix
    ./video-player.nix
    ./zoom.nix
  ];
}
