# Level 13 - fix-the-build

**Tier:** 4 Derivations   **Network:** YES   **Flakes needed:** no

## Story
Builds fail. When they do, Nix tells you which derivation, which phase, and
keeps the log. Reading that log is how packagers spend half their lives.

## Goal
`default.nix` is supposed to build a package whose `flag` file contains the flag.
Right now `nix-build` fails. Find out why, fix the smallest thing that is wrong,
rebuild, and submit the contents of `result/flag`.

## What you need to know
- Build logs: `nix log`, or the tail printed on failure.
  https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-log
- Phases (see level 12): https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases
- Inside a sandboxed build the working directory is a throwaway temp dir.

## Commands that may help
`nix-build`, `nix log`, `cat`

Submit: `wargame submit 13 'FLAG{...}'`
