let
  pkgs = import ./pin.nix { };
in
pkgs.stdenv.mkDerivation {
  pname = "cursed";
  version = "1.0";
  dontUnpack = true;

  buildPhase = ''
    printf 'FLAG{%s}\n' "$(printf '%s' "$pname-$version" | sha256sum | cut -c1-16)" > flag.txt
  '';

  installPhase = ''
    mkdir -p $out
    cp flag.text $out/flag
  '';
}
