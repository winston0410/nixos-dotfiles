{ pkgs, ... }:

pkgs.mkShell {
  buildInputs = [ ];

  shellHook = ''
    echo hello
  '';
}
