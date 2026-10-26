cat > default.nix <<'NIX'
let
  pkgs = import ./pin.nix { };
in
pkgs.stdenv.mkDerivation {
  pname = "greeter";
  version = "1.0";
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    printf '#!/bin/sh\necho "hello from phase"\n' > $out/bin/greeter
    chmod +x $out/bin/greeter
  '';
}
NIX
nix-build -o result >/dev/null
./check.sh result
