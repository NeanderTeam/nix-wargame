sed -i 's|^base$|base.override { greeting = "overridden from outside"; }|' default.nix
nix-build -o result >/dev/null
./check.sh result
