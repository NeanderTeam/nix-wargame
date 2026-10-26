# Level 25 - content-address

**Tier:** 8 Store internals   **Network:** no   **Flakes needed:** no

## Story
Store paths look like `/nix/store/<hash>-<name>`. The hash is not random: it is
computed from the contents (for plain files) or from the build recipe (for
derivations). Put the same file in a store twice and you get the same path; put
it in a different store *location* and you still get the same path name.

## Goal
Add `blob.txt` to the Nix store, then run `./check.sh <store path>`.
To keep your real `/nix/store` untouched, use a throwaway store that lives inside
your scratch dir: a local store rooted at `./store` (see `--store`).

## What you need to know
- `nix-store --add`: https://nixos.org/manual/nix/stable/command-ref/nix-store/add
- Store paths: https://nixos.org/manual/nix/stable/store/store-path
- Local stores and the `--store` option: https://nixos.org/manual/nix/stable/store/types/local-store
- Nix Pills 18, "Nix store paths": https://nixos.org/guides/nix-pills/18-nix-store-paths.html

## Commands that may help
`nix-store --add`, `ls`

Submit: `wargame submit 25 'FLAG{...}'`
