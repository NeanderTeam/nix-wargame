cat > shell.nix <<'NIX'
let
  pkgs = import ./pin.nix { };
in
pkgs.mkShell {
  packages = [ pkgs.hello ];
  LEVEL_TOKEN = "nine";
}
NIX
nix-shell --run ./check.sh
