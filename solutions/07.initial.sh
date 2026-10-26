# EXPECT-SUCCESS: a wrong input still yields a (different, non-matching) flag-shaped string.
# Decoy on purpose: a fake `pkgs` (the real unpinned <nixpkgs> may legitimately differ per host).
# Shows that the flag really depends on the pinned nixpkgs version.
nix-instantiate --eval --raw --arg pkgs "{ lib.version = \"0\"; }" flag.nix
