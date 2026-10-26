# Level 12 - build-phases

**Tier:** 4 Derivations   **Network:** YES   **Flakes needed:** no

## Story
`stdenv.mkDerivation` wraps `builtins.derivation` with a standard build process
split in *phases* (unpack, patch, configure, build, check, install, fixup).
You override only the phases you need.

## Goal
Complete `default.nix` so the package installs an executable `bin/greeter` that
prints `hello from phase`. Build it, then run `./check.sh result`.
The check also verifies that the script's `#!` line points into the Nix store
(hint: some phase fixes that for you automatically).

## What you need to know
- Phases: https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases
- Nix Pills 8, "Generic builders": https://nixos.org/guides/nix-pills/08-generic-builders.html
- `$out`, `mkdir -p`, `chmod +x`

## Commands that may help
`nix-build`, `cat`

Submit: `wargame submit 12 'FLAG{...}'`
