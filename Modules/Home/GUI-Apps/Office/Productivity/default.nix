{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./libreoffice.nix
    ./pdf-reader.nix
    ./printer-scan.nix
    ./thunderbird.nix
  ];
}
