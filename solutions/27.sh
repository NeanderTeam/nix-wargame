nix-build -o keepme >/dev/null
nix-store --query --roots "$(readlink -f keepme)" | ./check.sh
