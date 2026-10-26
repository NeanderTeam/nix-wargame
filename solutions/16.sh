cat > default.nix <<'NIX'
let
  pkgs = import ./pin.nix { };
in
pkgs.callPackage ./package.nix { greeting = "nix"; target = "wargame"; }
NIX
nix-build -o result >/dev/null
./check.sh result
