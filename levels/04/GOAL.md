# Level 04 - syntax-errors

**Tier:** 2 Language   **Network:** no   **Flakes needed:** no

## Story
Somebody left `broken.nix` half-finished. Nix error messages are terse but they
point at the exact line. Learning to read them is a core skill.

## Goal
Fix `broken.nix` so that its attribute `flag` evaluates, then submit that value.
Fix the file; do not rewrite it from scratch.

## What you need to know
- Nix language tutorial (let, attribute sets, `;`): https://nix.dev/tutorials/nix-language
- Builtins reference: https://nixos.org/manual/nix/stable/language/builtins

## Commands that may help
`nix-instantiate --eval --strict -A flag broken.nix`, a text editor

Submit: `wargame submit 04 'FLAG{...}'`
