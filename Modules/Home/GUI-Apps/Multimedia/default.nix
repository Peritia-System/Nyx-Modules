{ config, lib, pkgs, ... }:

{
  imports = [
    ./Audio
    ./Capture
    ./Graphics
    ./Video
  ];
}
