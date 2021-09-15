{
  description = "Configuration for my sysmem";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    dotfiles = { url = "github:winston0410/dotfiles-manager/master"; };
    universal = { url = "github:winston0410/universal-dotfiles/master"; };
  };

  outputs = { nixpkgs, home-manager, dotfiles, universal, ... }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware-configuration.nix
            home-manager.nixosModules.home-manager
            (universal.profiles.nixos.macbook2017 "hugosum")
          ];
        };
      };
    };
}
