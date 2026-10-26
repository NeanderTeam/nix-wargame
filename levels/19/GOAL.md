# Level 19 - flake-app

**Tier:** 6 Flakes   **Network:** YES   **Flakes needed:** YES

> Enable flakes **in your shell only** (no system config): `export NIX_CONFIG="experimental-features = nix-command flakes"` or `eval "$(./wargame env)"`.

## Story
`nix run` executes an *app* declared by a flake. An app is a tiny attribute set
with a fixed shape, and Nix is strict about it.

## Goal
`nix run .` currently fails. Make the app in `flake.nix` valid, run it, and
submit what it prints.

## What you need to know
- `nix run`: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-run
- Flake output schema for `apps`: https://wiki.nixos.org/wiki/Flakes#Output_schema

## Commands that may help
`nix run .`, `nix flake show`

Submit: `wargame submit 19 'FLAG{...}'`
