# Level 28 - boss

**Tier:** 9 Boss   **Network:** YES   **Flakes needed:** YES

> Enable flakes **in your shell only**: `eval "$(./wargame env)"` (or export `NIX_CONFIG="experimental-features = nix-command flakes"`).

## Story
Everything you learned, in one flake. A small team shipped `boss-tool` and
nothing works. Three independent problems are hiding in this project, each one
something you met before.

## Goal
Make `nix run .` print the flag, **without changing the contents of the
`data-v1` directory**. There is more than one way to feed it the right data;
choose cleanly.

## What you need to know
Everything from tiers 5, 6 and 7. No new documentation, only your notes.

## Commands that may help
`nix run`, `nix flake show`, `nix flake metadata`, `cat` every file

Submit: `wargame submit 28 'FLAG{...}'`
