{ config, lib, pkgs, ... }:

{
  imports = [
    ./kdenlive.nix
    ./zoom.nix
  ];
}
