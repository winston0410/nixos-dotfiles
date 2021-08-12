{ config, lib, pkgs, ... }:

with lib;

{
  environment.systemPackages = with pkgs; [ lorri ];

  # lorri
  systemd.user = {
    services.lorri = {
      description = "lorri build daemon";
      after = [ "lorri.socket" ];
      restartIfChanged = false;

      serviceConfig = {
        ExecStart = "${pkgs.lorri}/bin/lorri daemon";
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        Restart = "on-failure";
        Environment = let
          path = with pkgs; makeSearchPath "bin" [ nix gitMinimal gnutar gzip ];
        in [ "PATH=${path}" ];
      };
    };

    sockets.lorri = {
      description = "Socket for lorri build daemon";

      socketConfig = {
        ListenStream = "%t/lorri/daemon.socket";
        RuntimeDirectory = "lorri";
      };

      wantedBy = [ "sockets.target" ];
    };
  };
  # fusuma

  # bar(what bar to use)?
}
