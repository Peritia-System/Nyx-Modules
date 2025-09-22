{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./vnc-server.nix
  ];
}
