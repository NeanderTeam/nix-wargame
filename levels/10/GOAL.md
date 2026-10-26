# Level 10 - pure-shell

**Tier:** 3 Shells & ad-hoc   **Network:** YES   **Flakes needed:** no

## Story
A normal `nix-shell` *adds* tools to your existing environment, so host tools and
stray variables can leak in and make "works on my machine" bugs. `--pure` throws
the inherited environment away so only what the shell declares is visible.

## Goal
In your own terminal, first pollute the environment:
`export WARGAME_LEAK=yes WARGAME_KEEP=ok`
Then enter the project shell from `shell.nix` so that, inside it:
1. `WARGAME_LEAK` is **not** set (nothing leaks in),
2. `WARGAME_KEEP` is still `ok` (you deliberately let this one through),
3. `hello` comes from the Nix store.
Run `./check.sh` inside that shell (e.g. with `--run`) and submit what it prints.

## What you need to know
- `nix-shell --pure` and `--keep`: https://nixos.org/manual/nix/stable/command-ref/nix-shell
- Why purity matters: https://nix.dev/tutorials/first-steps/ad-hoc-shell-environments

## Commands that may help
`nix-shell`, `env`, `printenv`

Submit: `wargame submit 10 'FLAG{...}'`
