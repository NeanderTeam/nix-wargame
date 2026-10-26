# Level 23 - overlay

**Tier:** 7 Overlays/overrides   **Network:** YES   **Flakes needed:** no

## Story
Overriding one package at a call site is fine; overriding it *everywhere* in a
package set is what an *overlay* is for. An overlay is a function
`final: prev: { ... }` that returns attributes to add or replace.

## Goal
Write `overlay.nix` so that the pinned package set gains a new attribute
`wargame-hello`: a script (`writeShellScriptBin "wargame-hello"`) that prints
`wargame-hello: GNU hello <version>`, where `<version>` is the version of the
set's `hello` package. `default.nix` already applies your overlay. Build it,
then run `./check.sh result`.

## What you need to know
- Overlays: https://nixos.org/manual/nixpkgs/stable/#chap-overlays
- `final` vs `prev`: https://nix.dev/tutorials/callpackage  (and Nix Pills 17, https://nixos.org/guides/nix-pills/17-nixpkgs-overriding-packages.html)
- `pkg.version` is an attribute of nixpkgs packages.

## Commands that may help
`nix-build`, `cat default.nix`

Submit: `wargame submit 23 'FLAG{...}'`
