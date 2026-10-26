# Level 09 - shell-nix

**Tier:** 3 Shells & ad-hoc   **Network:** YES   **Flakes needed:** no

## Story
Typing `-p` every time gets old. A `shell.nix` describes a project's development
environment declaratively, so everyone who enters it gets the same tools and
variables.

## Goal
Complete `shell.nix` so that inside `nix-shell`:
1. `hello` is available, and
2. the environment variable `LEVEL_TOKEN` equals `nine`.
Then run `nix-shell --run ./check.sh` and submit what it prints.

## What you need to know
- `pkgs.mkShell`: https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-mkShell
- Declarative shell environments: https://nix.dev/tutorials/first-steps/declarative-shell
- Attributes you pass to `mkShell` that are not special become environment variables.

## Commands that may help
`nix-shell`, `cat`

Submit: `wargame submit 09 'FLAG{...}'`
