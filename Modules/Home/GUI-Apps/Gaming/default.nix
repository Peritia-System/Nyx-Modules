{ config, lib, pkgs, ... }:

{
  imports = [
    ./classic-game-collection.nix
    ./prismlauncher.nix
  ];
}
