let
  pkgs = import ./pin.nix { };
in
pkgs.runCommand "rooted" { } ''
  echo "I am protected by a root" > $out
''
