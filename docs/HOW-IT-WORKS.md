# How it works

## Layout

```
wargame            the CLI (bash, coreutils + nix only)
common/            copied into every scratch dir: pin.nix, pin.env
levels/NN/         GOAL.md, title, tier, hints/{1,2,3}.md, flag.sha256, files/
solutions/NN.sh    spoilers; one script per level; used by CI
tools/             verify-solutions, new-level, strip-solutions, bump-pin, self-test
templates/level/   skeleton used by tools/new-level.sh
```

## Play loop

`wargame start N` copies `common/` and `levels/NN/files/` into
`${XDG_CACHE_HOME:-~/.cache}/nix-wargame/play/NN` (so the repo stays clean and a
level can be redone with `--fresh`), substitutes the nixpkgs pin placeholders
(`@NIXPKGS_REV@`, `@NIXPKGS_HASH@`) and prints `GOAL.md`.

`wargame submit N FLAG` hashes the submitted string (a `FLAG{...}` substring is
extracted, so pasted noise is tolerated) and compares with `levels/NN/flag.sha256`.
Success appends `passed NN <epoch>` to
`${XDG_STATE_HOME:-~/.local/state}/nix-wargame/progress`. Level N is unlocked when N-1
is passed. Hints are counted in the same file (`hints NN k`).

## Flags

Flags are produced by the player's own work. Typically a Nix expression computes
`FLAG{<16 hex of sha256 of something>}`; the something depends on the right
result (a build output, a store path name, a package version from the pin). Some
levels ship a `check.sh` that verifies the player's result first and then prints
the flag derived from it. The repository only contains the sha256 of each flag.

## Flakes

The game never edits Nix config. Its own commands (`doctor`, tools) set
`NIX_CONFIG='experimental-features = nix-command flakes'` for themselves.
Players enable it in their shell with `eval "$(wargame env)"`.

## Pinning

All nixpkgs access goes through `common/pin.nix` / `pin.env` (non-flake levels) or
the `@NIXPKGS_REV@` placeholder in a level's `flake.nix`. Bump everything at once:

```sh
tools/bump-pin.sh <40-hex-rev>
tools/verify-solutions.sh          # find levels whose flag depends on versions
tools/verify-solutions.sh --update 07 08 ...   # after reviewing
```

Also update `inputs.nixpkgs.url` in the root `flake.nix`.

## Cohorts

For a class that wants flags that differ from the public ones, change the salt
strings (`l08:`, `l09:` ...) in the `check.sh` / `.nix` files, update the hashes
with `tools/verify-solutions.sh --update`, and distribute that fork.
