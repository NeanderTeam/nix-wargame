let
  pkgs = import ./pin.nix { };
in
pkgs.writeShellScriptBin "wrapper" ''
  exec ${pkgs.hello}/bin/hello "$@"
''
