let
  pkgs = import ./pin.nix { };
  base = pkgs.callPackage ./pkg.nix { };
in
# TODO: override version and add share/note
base
