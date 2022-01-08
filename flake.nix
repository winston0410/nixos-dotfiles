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
                  
                Host oracle1
                  HostName ${secret.ip.oracle1}
                  User root
              '';

              virtualisation.oci-containers.backend = "docker";
            });
            hardware = import hardware;
            profile = ((universal.profiles.home.dev).override {
              userProfile = (universal.profiles.user.hugosum);
            });

            k8s = ({ pkgs, ... }: {
              networking.firewall.allowedTCPPorts = [ 6443 ];

              services.k3s = { enable = true; };

              environment.systemPackages = [ pkgs.k3s ];
            });

            accent = ({ pkgs, lib, config, ... }:
              let
                mkDockerNetwork = ip: name:
                  let
                    docker = config.virtualisation.oci-containers.backend;
                    dockerBin = "${pkgs.${docker}}/bin/${docker}";
                  in ''
                    ${dockerBin} network inspect ${name} >/dev/null 2>&1 || ${dockerBin} network create ${name} --subnet ${ip}
                  '';
              in {
                system.activationScripts.mkVolume = lib.stringAfter [ "var" ] ''
                  mkdir -p /var/lib/accent
                '';

                system.activationScripts.mkNetwork =
                  mkDockerNetwork "172.22.0.0/16" "accent";

                virtualisation.oci-containers.containers.accent = {
                  image = "mirego/accent:v1.9.1";
                  ports = [ "4000:4000" ];
                  environment = {
                    PORT = "4000";
                    DUMMY_LOGIN_ENABLED = "1";
                    DATABASE_URL =
                      "postgres://postgres:password@172.22.0.2:5432/accent";
                  };
                  extraOptions = [ "--network=accent" ];
                  dependsOn = [ "accent-postgres" ];
                };

                virtualisation.oci-containers.containers.accent-postgres = {
                  image = "postgres:14.1";
                  environment = {
                    POSTGRES_DB = "accent";
                    POSTGRES_USER = "postgres";
                    POSTGRES_PASSWORD = "password";
                  };
                  volumes = [ "/var/lib/accent:/var/lib/postgresql/data" ];
                  extraOptions = [ "--network=accent" "--ip=172.22.0.2" ];
                };

                #NOTE Configuration for calendso
                # system.activationScripts.mkCalendsoVolume =
                # lib.stringAfter [ "var" ] ''
                # mkdir -p /var/lib/calendso
                # '';

                # system.activationScripts.mkCalendsoNetwork =
                # mkDockerNetwork "172.23.0.0/16" "calendso";

                # virtualisation.oci-containers.containers.calendso = {
                # image = "calendso/calendso:latest";
                # ports = [ "3010:3000" ];
                # environment = {
                # BASE_URL = "http://localhost:3000";
                # NEXT_PUBLIC_APP_URL = "http://localhost:3000";
                # DATABASE_URL =
                # "postgres://postgres:password@calendso-postgres:5432/calendso";
                # };
                # extraOptions = [ "--network=calendso" ];
                # dependsOn = [ "calendso-postgres" ];
                # };

                # virtualisation.oci-containers.containers.calendso-postgres = {
                # image = "postgres:14.1";
                # environment = {
                # POSTGRES_DB = "calendso";
                # POSTGRES_USER = "user";
                # POSTGRES_PASSWORD = "password";
                # };
                # volumes = [ "/var/lib/calendso:/var/lib/postgresql/data" ];
                # extraOptions = [ "--network=calendso" "--ip=172.23.0.2" ];
                # };
              });
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
