{ config, lib, pkgs, ... }:

{
  imports = [
    ./office-apps.nix
    ./printer-scan.nix
  ];
}
