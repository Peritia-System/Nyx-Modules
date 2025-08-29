{ config, lib, pkgs, ... }:

{
  imports = [
    ./Hardware
    ./Home
    ./System
  ];
}
