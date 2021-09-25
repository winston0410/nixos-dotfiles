{
  description = "Configuration for my sysmem";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    universal = {
      url = "path:/home/hugosum/universal-dotfiles";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
  };

  outputs = { nixpkgs, universal, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        nixos = ((universal.profiles.system.nixos).override {
          modules = {
            hardware = ./hardware-configuration.nix;
            profile = ((universal.profiles.home.dev).override {
              userProfile = (universal.profiles.user.hugosum);
            });
          };
        });
      };
      devShell.${system} =
        (import ./shell.nix) { pkgs = nixpkgs.legacyPackages.${system}; };
    };
}
