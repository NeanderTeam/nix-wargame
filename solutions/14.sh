got=$(nix-build -o result 2>&1 | grep -o 'got: *sha256-[A-Za-z0-9+/=]*' | head -n1 | sed 's/got: *//' || true)
[ -n "$got" ] || { echo "no hash found in nix-build output" >&2; exit 1; }
sed -i "s|pkgs.lib.fakeHash;.*|\"$got\";|" default.nix
nix-build -o result >/dev/null
cat result
