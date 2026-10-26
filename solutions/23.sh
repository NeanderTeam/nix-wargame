cat > overlay.nix <<'NIX'
final: prev: {
  wargame-hello = final.writeShellScriptBin "wargame-hello" ''
    echo "wargame-hello: GNU hello ${final.hello.version}"
  '';
}
NIX
nix-build -o result >/dev/null
./check.sh result
