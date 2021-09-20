{
  description = "Configuration for my sysmem";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    dotfiles-manager = {
      url = "github:winston0410/dotfiles-manager/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    universal = {
      url = "github:winston0410/universal-dotfiles/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        dotfiles-manager.follows = "dotfiles-manager";
      };
    };
    eww = {
      url = "github:elkowar/eww/master";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles-manager, universal, eww, ... }:
    let system = "x86_64-linux";
    in {
      overlay = final: prev: {
        "eww" = eww.packages.eww;
      };
      
      nixosModule = { pkgs, ... }: {
        nixpkgs.overlays = [ self.overlay ];
        environment.systemPackages = [ pkgs.eww ];
      };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            home-manager.nixosModules.home-manager
            (universal.profiles.nixos.macbook2017 "hugosum")
          ];
        };
      };
      devShell.${system} =
        (import ./shell.nix) { pkgs = nixpkgs.legacyPackages.${system}; };
    };
}
