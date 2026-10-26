# Level 07 - pinned-nixpkgs

**Tier:** 2 Language   **Network:** YES (downloads a pinned nixpkgs tarball, ~40 MB)   **Flakes needed:** no

## Story
`nixpkgs` is the giant library of packages and helper functions. "Which nixpkgs?"
decides what you get, so reproducible projects *pin* it. The scratch dir contains
`pin.nix`, a tiny file that fetches one exact nixpkgs revision.

## Goal
`flag.nix` is a function of one argument, `pkgs`. Call it with the package set
produced by `pin.nix` and submit the result. The flag depends on the pinned
nixpkgs version, so you really have to use the pin.

## What you need to know
- Pinning nixpkgs: https://nix.dev/tutorials/first-steps/towards-reproducibility-pinning-nixpkgs
- `builtins.fetchTarball`, and `import` of a file that returns a function.

## Commands that may help
`cat pin.nix`, `nix-instantiate --eval --arg ...`

Submit: `wargame submit 07 'FLAG{...}'`
