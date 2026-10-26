let
  pkgs = import ./pin.nix { };
in
pkgs.mkShell {
  packages = [ pkgs.hello ];
}
