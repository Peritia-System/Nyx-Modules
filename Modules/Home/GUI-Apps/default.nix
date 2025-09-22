{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./Browsers
    ./Communication
    ./Development
    ./Gaming
    ./Multimedia
    ./Office
    ./VPN
  ];
}
