{
  description = "Configuration for my sysmem";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    universal = {
      url = "github:winston0410/universal-dotfiles/master";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
  };

  outputs = inputs:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        nixos = (inputs.universal.profiles.nixos {
          extraModules = ([
            ./hardware-configuration.nix
            (inputs.universal.profiles.user.dev { } "hugosum")
          ]);
        });
      };
      devShell.${system} = (import ./shell.nix) {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      };
    };
}
