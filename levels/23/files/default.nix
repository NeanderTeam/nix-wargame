let
  pkgs = import ./pin.nix { overlays = [ (import ./overlay.nix) ]; };
in
pkgs.wargame-hello
