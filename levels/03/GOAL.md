# Level 03 - repl

**Tier:** 1 Basics/CLI   **Network:** no   **Flakes needed:** no

## Story
The best way to learn a language is to poke it. `nix repl` is an interactive
session where you can load files, inspect values and call functions.

## Goal
`puzzle.nix` holds a set `zoo`, a riddle and a function `answer`.
Find how many attributes `zoo` has, hand that number to `answer`, and submit what
comes back. Use the repl to load the file and explore.

## What you need to know
- `nix repl`: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-repl
- Repl commands start with `:` (try `:?`). `:l <file>` loads a file.
- Builtins: https://nixos.org/manual/nix/stable/language/builtins

## Commands that may help
`nix repl`, `cat`. Piping into the repl works too: `printf 'expr\n' | nix repl ...`

Submit: `wargame submit 03 'FLAG{...}'`
