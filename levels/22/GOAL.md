# Level 22 - override-attrs

**Tier:** 7 Overlays/overrides   **Network:** YES   **Flakes needed:** no

## Story
`.override` changes function *arguments*. `.overrideAttrs` changes the attributes
passed to `mkDerivation` itself: version, phases, patches, flags...

## Goal
`pkg.nix` is a plain derivation (version `1.0`, no `share/note`). Without editing
it, change `default.nix` so the resulting package has version `2.0` **and**
contains a file `share/note` with the exact text `patched via overrideAttrs`.
Build and run `./check.sh result`.

## What you need to know
- `overrideAttrs`: https://nixos.org/manual/nixpkgs/stable/#sec-pkg-overrideAttrs
- Phase hooks: `postInstall` runs after `installPhase`.
- The function receives the *previous* attributes (conventionally `old`).

## Commands that may help
`nix-build`, `cat pkg.nix`

Submit: `wargame submit 22 'FLAG{...}'`
