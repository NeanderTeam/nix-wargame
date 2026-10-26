sed -i 's/flag\.text/flag.txt/' default.nix
nix-build -o result >/dev/null
cat result/flag
