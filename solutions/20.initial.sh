# Premise: without the experimental features flakes are refused outright.
env -u NIX_CONFIG nix flake show . 2>&1 | grep -q "experimental Nix feature" || echo "PREMISE BROKEN: flakes not refused"
nix develop -c ./check.sh
