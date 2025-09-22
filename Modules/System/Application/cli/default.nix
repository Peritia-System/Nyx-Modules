{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./docker.nix
    ./openssh.nix
    ./podman.nix
    ./vm.nix
    ./zsh.nix
  ];
}
