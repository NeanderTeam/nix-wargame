let
  pkgs = import ./pin.nix { };
in
pkgs.runCommand "fod-demo"
{
  outputHashMode = "flat";
  outputHashAlgo = "sha256";
  outputHash = pkgs.lib.fakeHash; # TODO: replace with the real hash
}
  ''
    printf 'FLAG{%s}\n' "$(printf wargame13 | sha256sum | cut -c1-16)" > $out
  ''
