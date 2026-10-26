nix-instantiate --eval --raw --expr "(import ./mk.nix) (import ./defaults.nix // import ./overrides.nix)"
