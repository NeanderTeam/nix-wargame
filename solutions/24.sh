nix-build -o result >/dev/null
g=$(nix-store -qR result | grep -E -- '-glibc-[0-9.]+-[0-9]+$' | head -n1)
./check.sh "$g"
