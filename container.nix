{ config, lib, pkgs, ... }:

{
  environment.variables = { DOCKER_BUILDKIT = "1"; };

  environment.systemPackages = with pkgs; [
    docker-compose
    kompose
    kubectl
    kubernetes
    kubernix
  ];

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };
    };
  };
}