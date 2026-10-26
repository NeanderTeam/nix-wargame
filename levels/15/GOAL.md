# Level 15 - shell-application

**Tier:** 5 Packaging   **Network:** YES   **Flakes needed:** no

## Story
You wrote a small shell script, `tool.sh`. On your machine it works because `jq`
happens to be installed. Packaged properly, a script should *declare* its runtime
dependencies so it works anywhere and uses exactly the tools you named.

## Goal
Turn `tool.sh` into a package named `wargame-tool` with `writeShellApplication`,
declaring what it needs at runtime (read the script!). Build it and run
`result/bin/wargame-tool` from the scratch dir; it prints the flag.
The script refuses to run if its tools do not come from the Nix store.

## What you need to know
- `writeShellApplication`: https://nixos.org/manual/nixpkgs/stable/#trivial-builder-writeShellApplication
- Trivial builders overview: https://nixos.org/manual/nixpkgs/stable/#chap-trivial-builders

## Commands that may help
`nix-build`, `cat tool.sh`

Submit: `wargame submit 15 'FLAG{...}'`
