# Level 16 - callpackage

**Tier:** 5 Packaging   **Network:** YES   **Flakes needed:** no

## Story
Nixpkgs packages are *functions* from their dependencies to a derivation.
`callPackage` fills each argument automatically from the package set, and lets
you pass extra or replacement arguments yourself.

## Goal
`package.nix` is a function with arguments `writeShellScriptBin`, `greeting`
(has a default) and `target` (no default). Write `default.nix` so that it builds
`package.nix` with `callPackage`, passing `greeting = "nix"` and
`target = "wargame"`. Build it and run `./check.sh result`.

## What you need to know
- The `callPackage` pattern: https://nix.dev/tutorials/callpackage
- Nix Pills 13, "Callpackage design pattern": https://nixos.org/guides/nix-pills/13-callpackage-design-pattern.html

## Commands that may help
`nix-build`, `cat package.nix`

Submit: `wargame submit 16 'FLAG{...}'`
