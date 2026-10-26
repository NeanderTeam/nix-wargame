# Level 20 - flake-devshell

**Tier:** 6 Flakes   **Network:** YES   **Flakes needed:** YES

> Enable flakes **in your shell only**: `eval "$(./wargame env)"` (or export `NIX_CONFIG="experimental-features = nix-command flakes"`).

## Story
Flakes replace `shell.nix` with a `devShells` output, entered with `nix develop`.
Same idea as level 09, but the inputs are locked, so the whole team gets the same shell.

## Goal
Complete the `devShells.default` of `flake.nix` so that, inside `nix develop`:
1. `hello` is available, and
2. `LEVEL_TOKEN` equals `twenty`.
Then run `nix develop -c ./check.sh` and submit what it prints.

## What you need to know
- `nix develop`: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-develop
- `devShells` output: https://wiki.nixos.org/wiki/Flakes#Output_schema
- `mkShell` (level 09)

## Commands that may help
`nix develop`, `nix flake show`

Submit: `wargame submit 20 'FLAG{...}'`
