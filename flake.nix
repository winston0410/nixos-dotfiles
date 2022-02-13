{
  description = "Configuration for my sysmem";

  inputs = {
    universal = { url = "path:/home/hugosum/universal-dotfiles"; };

    hardware = {
      url = "path:/etc/nixos/hardware-configuration.nix";
      flake = false;
    };

    kratos = {
      url = "path:/home/hugosum/ory-kratos-flake";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    secret = { url = "path:/home/hugosum/secret"; };
  };

  outputs = { self, nixpkgs, universal, hardware, kratos, secret, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = ((universal.profiles.system.nixos).override {
          modules = {
            adhoc = ({ pkgs, ... }: {
              programs.ssh.extraConfig = ''
                Host netcup
                  HostName ${secret.ip.netcup}
                  User root
                  
                #NOTE default image of oracle instance doesn't accept root. Use root after infection
                Host oracle1
                  HostName ${secret.ip.oracle1}
                  User root
                  
                Host oracle2
                  HostName ${secret.ip.oracle2}
                  User root
              '';
            });
            hardware = import hardware;
            profile = ((universal.profiles.home.dev).override {
              userProfile = (universal.profiles.user.hugosum);
            });

            # k8s = ({ pkgs, ... }: {
            # networking.firewall.allowedTCPPorts = [ 6443 ];

            # services.k3s = { enable = true; };

            # environment.systemPackages = [ pkgs.k3s ];
            # });
          };
        });
        k3sVm = (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ pkgs, ... }: {
              boot.isContainer = true;

              system.stateVersion = "21.11";
            })
          ];
        });
      };
      devShell.${system} = (({ pkgs, ... }:
        pkgs.mkShell {
          buildInputs = [ ];

          shellHook = ''
            nix flake lock --update-input universal
          '';
        }) { inherit pkgs; });
    };
}
