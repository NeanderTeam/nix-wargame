# Level 00 - first-eval

**Tier:** 1 Basics/CLI   **Network:** no   **Flakes needed:** no

## Story
Welcome. Everything in Nix starts with one humble act: evaluating an expression.
Your scratch directory holds `flag.nix`. It is not a text file with a secret in
it; it is a *program* that computes the flag.

## Goal
Evaluate `flag.nix` and submit the string it produces.

## What you need to know
- Nix manual, `nix-instantiate --eval`:
  https://nixos.org/manual/nix/stable/command-ref/nix-instantiate
- Nix language basics: https://nix.dev/tutorials/nix-language

## Commands that may help
`nix-instantiate`, `cat`

Submit: `wargame submit 00 'FLAG{...}'`
