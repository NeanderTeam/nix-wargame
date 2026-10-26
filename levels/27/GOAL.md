# Level 27 - gc-roots

**Tier:** 8 Store internals   **Network:** YES   **Flakes needed:** no

## Story
The garbage collector deletes every store path that nothing points to. The things
it *does* respect are *roots*: profiles, running processes, and the `result`
symlinks that `nix-build` leaves behind. (We will NOT run the collector here; this
game never garbage-collects your store.)

## Goal
Build `default.nix` so that the output is linked as `./keepme` in your scratch dir,
then ask Nix which roots point at that store path, and pipe the answer into
`./check.sh`. (`./check.sh` expects the query output on stdin.)

## What you need to know
- GC roots: https://nixos.org/manual/nix/stable/package-management/garbage-collector-roots
- `nix-build --out-link` / `-o`, and `nix-store --query --roots`:
  https://nixos.org/manual/nix/stable/command-ref/nix-store/query

## Commands that may help
`nix-build -o`, `readlink -f`, `nix-store -q`

Submit: `wargame submit 27 'FLAG{...}'`
