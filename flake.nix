{
  description = "Nyx-Modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    ################################################################
    # NixOS Modules
    ################################################################
    nixosModules = {
      default = import ./Modules/System;
      hardware = import ./Modules/Hardware;
    };

    ################################################################
    # Home Manager Modules
    ################################################################
    homeManagerModules = {
      default = import ./Modules/Home;
    };
  };
}
