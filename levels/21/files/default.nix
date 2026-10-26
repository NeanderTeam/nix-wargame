let
  pkgs = import ./pin.nix { };
  base = pkgs.callPackage ./pkg.nix { };
in
# TODO: change the `greeting` argument of `base` without editing pkg.nix
base
