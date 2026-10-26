# Level 08 - ad-hoc-shell

**Tier:** 3 Shells & ad-hoc   **Network:** YES   **Flakes needed:** no

## Story
You need a tool *right now* and you do not want to install it. `nix-shell -p`
drops you into a shell where that package is on `PATH`, and leaves your system
untouched.

## Goal
Run GNU `hello` from the pinned nixpkgs (without installing it) and pipe the first
line of `hello --version` into `./check.sh`. It prints the flag. The version
you get depends on *which nixpkgs* you use, so use the pinned one:
`pin.env` defines `NIXPKGS_URL`.

## What you need to know
- `nix-shell -p`, `--run`, and `-I nixpkgs=...`:
  https://nixos.org/manual/nix/stable/command-ref/nix-shell
- Ad-hoc environments: https://nix.dev/tutorials/first-steps/ad-hoc-shell-environments

## Commands that may help
`nix-shell`, `source pin.env`

Submit: `wargame submit 08 'FLAG{...}'`
