{ stdenv }:
stdenv.mkDerivation {
  pname = "demo";
  version = "1.0";
  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    echo '#!/bin/sh' > $out/bin/demo
    chmod +x $out/bin/demo
    runHook postInstall
  '';
}
