cat > default.nix <<'NIX'
let
  pkgs = import ./pin.nix { };
  base = pkgs.callPackage ./pkg.nix { };
in
base.overrideAttrs (old: {
  version = "2.0";
  postInstall = ''
    mkdir -p $out/share
    printf '%s' 'patched via overrideAttrs' > $out/share/note
  '';
})
NIX
nix-build -o result >/dev/null
./check.sh result
