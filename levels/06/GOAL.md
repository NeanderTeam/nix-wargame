# Level 06 - merge-and-assert

**Tier:** 2 Language   **Network:** no   **Flakes needed:** no

## Story
Configuration in Nix is just attribute sets, and combining them is everyday work.
`mk.nix` is a function that takes a config set and only yields the flag if the
config is exactly right. Its `assert` messages tell you what is wrong.

## Goal
Build a config from `defaults.nix` and `overrides.nix` so that `mk.nix` accepts it,
then submit the flag. Requirements (all enforced by the asserts):
- scalar values from `overrides.nix` win over `defaults.nix`
- `ports` is the defaults list followed by the overrides list
- inside `nested`, keys from both files survive (overrides win on conflicts)

## What you need to know
- Operators `//` and `++`, and what "shallow" means:
  https://nix.dev/tutorials/nix-language  (Operators: `//` update, `++` concatenation)
- `assert`, `import`

## Commands that may help
`nix-instantiate --eval --raw --expr '...'`

Submit: `wargame submit 06 'FLAG{...}'`
