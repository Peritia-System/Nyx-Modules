{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./c-compiler.nix
    ./go.nix
    ./lua.nix
    ./python.nix
    ./rust.nix
    ./ruby.nix
  ];
}
