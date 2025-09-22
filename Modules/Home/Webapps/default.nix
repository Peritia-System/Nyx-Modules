{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./private-webapps.nix
    ./work-webapps.nix
  ];
}
