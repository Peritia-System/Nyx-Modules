{ config, lib, pkgs, ... }:

{
  imports = [
    ./all-grub.nix
    ./minegrub.nix
  ];
}
