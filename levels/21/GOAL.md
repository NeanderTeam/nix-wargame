# Level 21 - override

**Tier:** 7 Overlays/overrides   **Network:** YES   **Flakes needed:** no

## Story
You can change a package without touching its source file. `.override` changes
the *arguments* the package function was called with (see level 16).

## Goal
`default.nix` builds `pkg.nix` unchanged and the greeter says `hello, world`.
Change `default.nix` (not `pkg.nix`) so the greeter prints
`overridden from outside, world`. Build and run `./check.sh result`.

## What you need to know
- `override` vs `overrideAttrs`: https://nixos.org/manual/nixpkgs/stable/#sec-pkg-override
- Nix Pills 17, "Nixpkgs overriding packages": https://nixos.org/guides/nix-pills/17-nixpkgs-overriding-packages.html

## Commands that may help
`nix-build`, `cat pkg.nix`

Submit: `wargame submit 21 'FLAG{...}'`
