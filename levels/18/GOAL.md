# Level 18 - override-input

**Tier:** 6 Flakes   **Network:** no   **Flakes needed:** YES

> Enable flakes **in your shell only** (no system config): `export NIX_CONFIG="experimental-features = nix-command flakes"` or `eval "$(./wargame env)"`.

## Story
A flake's inputs are pinned in `flake.lock`. Sometimes you want to try the same
flake against a different input *without editing the file*, for instance a
local checkout of a dependency.

## Goal
`flake.nix` has an input `helper` that points at `./helper-v1`, and the
flake refuses to give you its flag while the helper is stale. A newer helper lives in
`./helper-v2`. Evaluate the output `lib.flag` using helper-v2 **without editing
`flake.nix`**, and submit it.

## What you need to know
- Flake inputs & lock files: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake#flake-inputs
- `--override-input` (see `nix eval --help`)
- `path:` flake references

## Commands that may help
`nix eval`, `nix flake metadata`

Submit: `wargame submit 18 'FLAG{...}'`
