let
  pkgs = import ./pin.nix { };
in
pkgs.stdenv.mkDerivation {
  pname = "greeter";
  version = "1.0";
  dontUnpack = true; # there is no source tarball in this exercise

  installPhase = ''
    # TODO: create $out/bin/greeter, an executable script printing "hello from phase"
  '';
}
