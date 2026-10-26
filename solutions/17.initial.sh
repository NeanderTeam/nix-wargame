# EXPECT-SUCCESS: building a decoy package works, it just is not the flag.
# Premise: without the experimental features flakes are refused outright.
env -u NIX_CONFIG nix flake show . 2>&1 | grep -q "experimental Nix feature" || echo "PREMISE BROKEN: flakes not refused"
nix build -o result .#alpha && cat result/flag
