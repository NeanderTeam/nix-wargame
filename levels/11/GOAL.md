# Level 11 - raw-derivation

**Tier:** 4 Derivations   **Network:** YES (fetches bash from the binary cache)   **Flakes needed:** no

## Story
Every package in Nix is, at the bottom, a *derivation*: a recipe saying "run this
builder with these inputs and put the result in `$out`". Higher-level helpers are
conveniences on top of one primitive: `builtins.derivation`.

## Goal
Complete the builder in `default.nix` so that the build writes the single line
`nix builds in a sandbox` into `$out` (a plain file). Build it with `nix-build`,
then run `./check.sh result`, which prints the flag.

## What you need to know
- Derivations: https://nix.dev/manual/nix/stable/language/derivations
- Nix Pills 6, "Our first derivation": https://nixos.org/guides/nix-pills/06-our-first-derivation.html

## Commands that may help
`nix-build`, `cat result`

Submit: `wargame submit 11 'FLAG{...}'`
