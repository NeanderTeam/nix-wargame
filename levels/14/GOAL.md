# Level 14 - fixed-output

**Tier:** 4 Derivations   **Network:** YES   **Flakes needed:** no

## Story
Most derivations are identified by their *inputs*. A *fixed-output derivation*
is identified by the hash of its *output* instead, which is how Nix lets some
builds (like downloads) touch the network and still stay reproducible. The classic
packager workflow: put a fake hash, build, and let Nix tell you the real one.

## Goal
`default.nix` declares an expected `outputHash` that is deliberately wrong
(`lib.fakeHash`). Build it, read the error, put the correct hash in, build again,
and submit the contents of `result`.

## What you need to know
- Fixed-output derivations: https://nix.dev/manual/nix/stable/language/advanced-attributes#adv-attr-outputHash
- Updating source hashes with a fake hash: https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-fetchers-updating-source-hashes-fakehash-method
- Hash format "SRI": `sha256-<base64>`

## Commands that may help
`nix-build`, `grep`, `sed`

Submit: `wargame submit 14 'FLAG{...}'`
