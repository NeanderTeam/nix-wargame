let
  pkgs = import ./pin.nix { };
in
pkgs.mkShell {
  # TODO 1: make `hello` available in the shell
  # TODO 2: export LEVEL_TOKEN="nine" into the shell environment
}
