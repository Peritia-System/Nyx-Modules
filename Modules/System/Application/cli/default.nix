{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker.nix
    ./openssh.nix
    ./vm.nix
    ./zsh.nix
  ];
}
