{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = [ ];

  shellHook = ''
    export FOO=BAR
  '';
}
