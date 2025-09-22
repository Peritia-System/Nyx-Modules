{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./custom-kernel-surfacepro-kbl.nix
  ];
}
