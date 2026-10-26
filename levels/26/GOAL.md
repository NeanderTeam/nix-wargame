# Level 26 - profiles

**Tier:** 8 Store internals   **Network:** YES   **Flakes needed:** no

## Story
A *profile* is a symlink chain to a generation, itself a symlink to a store path
that merges installed packages. Every change creates a new generation, so you can
roll back. Your own profile is off limits in this game, so we use a private one.

## Goal
Using **only** `--profile "$PLAY_DIR/profile"` (never your real profile; `$PLAY_DIR`
is your scratch dir, `wargame where 26`):
1. install `hello` from the pinned package set (`-f pin.nix`),
2. install `jq` as well,
3. roll back one generation, so that `hello` is present and `jq` is not.
Then run `./check.sh`.

## What you need to know
- `nix-env`, profiles & generations: https://nixos.org/manual/nix/stable/package-management/profiles
- `nix-env --install -A`, `--rollback`, `--list-generations`: https://nixos.org/manual/nix/stable/command-ref/nix-env

## Commands that may help
`export PLAY_DIR=$PWD`, `nix-env`, `ls -l profile*`

Submit: `wargame submit 26 'FLAG{...}'`
