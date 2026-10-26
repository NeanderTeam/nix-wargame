# Level 24 - closure

**Tier:** 8 Store internals   **Network:** YES   **Flakes needed:** no

## Story
A store path knows exactly which other store paths it refers to. Direct references
form a graph; the transitive set is its *closure*, everything needed to run it
anywhere. This is how Nix copies software between machines.

## Goal
`default.nix` builds a tiny wrapper script that mentions `hello`. Build it as
`result`. Then find the store path of **glibc** (the plain `...-glibc-<version>-<n>`
path, not `-dev`, `-bin`, ...) that is in the wrapper's *closure* but **not** one of its
*direct* references. Run `./check.sh <that-path>`.

## What you need to know
- `nix-store --query` (`--references`, `--requisites` / `-R`):
  https://nixos.org/manual/nix/stable/command-ref/nix-store/query
- Nix Pills 9, "Automatic runtime dependencies": https://nixos.org/guides/nix-pills/09-automatic-runtime-dependencies.html

## Commands that may help
`nix-build`, `nix-store -q`, `grep`

Submit: `wargame submit 24 'FLAG{...}'`
