# Level 05 - laziness

**Tier:** 2 Language   **Network:** no   **Flakes needed:** no

## Story
Nix only computes what it is asked for. That is why a huge package set can exist
without exploding. `lazy.nix` is full of landmines (`throw`, `abort`), yet the flag
is perfectly reachable.

## Goal
Get the value of `flag` out of `lazy.nix` without tripping any landmine.
Evaluating the *whole* file will fail; evaluating just the right part will not.

## What you need to know
- Laziness: https://nix.dev/manual/nix/stable/language/evaluation  (and the Nix Pills, "Basics of the language")
  https://nixos.org/guides/nix-pills/04-basics-of-language.html
- `--strict` forces deep evaluation, `-A` selects an attribute.

## Commands that may help
`nix-instantiate --eval`, `cat`

Submit: `wargame submit 05 'FLAG{...}'`
