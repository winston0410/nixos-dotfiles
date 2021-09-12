{
  description = "Configuration for my sysmem";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    dotfiles = { url = "github:winston0410/universal-dotfiles/master"; };
  };

  outputs = { nixpkgs, home-manager, dotfiles, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./hardware-configuration.nix
            home-manager.nixosModules.home-manager
            (dotfiles.lib.createUserProfile "hugosum" ([
              dotfiles.modules.windowManager.leftwm
              dotfiles.modules.nixos.config.minimal
              dotfiles.modules.multiplexer.tmux
              dotfiles.modules.misc.bibata-cursor
            ] ++ dotfiles.collections.devMachine))
            ./xserver.nix
          ];
        };
      };
    };
}

# {
# home-manager.useGlobalPkgs = true;
# home-manager.useUserPackages = true;
# home-manager.users.hugosum = { ... }@args: {
# imports = [
# ./home-manager.nix
# ];
# };
# }
