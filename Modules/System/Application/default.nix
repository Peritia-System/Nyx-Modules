{ config, lib, pkgs, ... }:

{
  imports = [
    ./cli
    ./Gaming
    ./Grub
    ./Special-Applications
  ];
}
