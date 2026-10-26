# Level 17 - flake-outputs

**Tier:** 6 Flakes   **Network:** YES   **Flakes needed:** YES

> Enable flakes **in your shell only** (no system config): `export NIX_CONFIG="experimental-features = nix-command flakes"` or `eval "$(./wargame env)"`.

## Story
A flake is a directory with a `flake.nix` that declares *inputs* and a fixed
schema of *outputs* (`packages`, `devShells`, `apps`, ...). Tools can inspect the
outputs without building anything.

## Goal
`flake.nix` exports four packages: `alpha`, `beta`, `gamma`, `delta`. Exactly one has
a `meta.description` announcing that it holds the flag. Find it by *inspecting*
the flake, build only that one, and submit the contents of its `flag` file.

## What you need to know
- Flakes: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake
- `nix flake show`, `nix eval`, `nix build`
- Your system string (e.g. `x86_64-linux`): `nix eval --impure --raw --expr builtins.currentSystem`

## Commands that may help
`nix flake show`, `nix eval`, `nix build`

Submit: `wargame submit 17 'FLAG{...}'`
