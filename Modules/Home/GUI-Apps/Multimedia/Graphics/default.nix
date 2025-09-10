{ config, lib, pkgs, ... }:

{
  imports = [
    ./image-viewer.nix
    ./krita.nix
  ];
}
