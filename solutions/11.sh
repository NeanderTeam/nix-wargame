sed -i 's|^.*# TODO: write.*$|      echo "nix builds in a sandbox" > "$out"|' default.nix
nix-build --no-out-link -o result >/dev/null
nix-build -o result >/dev/null
./check.sh result
