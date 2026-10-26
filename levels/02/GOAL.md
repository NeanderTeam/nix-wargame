# Level 02 - new-cli

**Tier:** 1 Basics/CLI   **Network:** no   **Flakes needed:** no

## Story
Nix has two command-line generations: the classic `nix-*` tools and the newer
unified `nix` command. The new one is still gated behind an *experimental
feature* named `nix-command`, so out of the box it politely refuses to work.

## Goal
Using the new `nix eval`, read the attribute `answer.flag` of `data.nix`
and submit it. Do **not** edit any system configuration: enable the feature
for a single invocation only.

> This level assumes `nix-command` is **not** already enabled in your shell.
> If `echo "$NIX_CONFIG"` prints something, run `unset NIX_CONFIG` first.

## What you need to know
- Experimental features: https://nixos.org/manual/nix/stable/contributing/experimental-features
- `nix eval`: https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-eval

## Commands that may help
`nix eval`, `nix --help`

Submit: `wargame submit 02 'FLAG{...}'`
