# Level 01 - arguments

**Tier:** 1 Basics/CLI   **Network:** no   **Flakes needed:** no

## Story
Plenty of Nix files are not values but *functions*. Evaluating such a file
without arguments gives you a lambda, not an answer.

## Goal
`flag.nix` is a function taking `who` and `times`. Evaluate it with
`who` = the string `wargame` and `times` = the integer `3`, and submit the result.
Mind the types: the file asserts them.

## What you need to know
- `nix-instantiate` options `--arg` and `--argstr`:
  https://nixos.org/manual/nix/stable/command-ref/nix-instantiate
- Nix language, functions: https://nix.dev/tutorials/nix-language#functions

## Commands that may help
`nix-instantiate`, `cat`

Submit: `wargame submit 01 'FLAG{...}'`
