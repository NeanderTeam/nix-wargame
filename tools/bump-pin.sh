#!/usr/bin/env bash
# Bump the nixpkgs pin used by every level.
# Usage: tools/bump-pin.sh <nixpkgs-rev>
# Afterwards run `tools/verify-solutions.sh`; flags that depend on package
# versions (07, 08, 09, 10, 20, 23, 24, 26) may need `tools/verify-solutions.sh --update NN`
# after you reviewed that the solution still makes sense.
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
rev=${1:?usage: tools/bump-pin.sh <nixpkgs-rev>}
[[ $rev =~ ^[0-9a-f]{40}$ ]] || { echo "rev must be a 40-hex commit id" >&2; exit 1; }
hash=$(NIX_CONFIG='experimental-features = nix-command flakes' \
  nix flake prefetch --json "github:NixOS/nixpkgs/$rev" | jq -r .hash)
[[ $hash == sha256-* ]] || { echo "could not determine hash" >&2; exit 1; }
cat >"$ROOT/common/pin.env" <<PIN
# Single source of truth for the nixpkgs pin used by every level.
# Bump with: tools/bump-pin.sh <rev>   (then re-run tools/verify-solutions.sh)
NIXPKGS_REV=$rev
NIXPKGS_HASH=$hash
NIXPKGS_URL=https://github.com/NixOS/nixpkgs/archive/$rev.tar.gz
PIN
# Keep the root flake in sync (single pin everywhere) and refresh its lock file.
sed -i -E "s|(inputs.nixpkgs.url = \"github:NixOS/nixpkgs/)[0-9a-f]{40}|\\1$rev|" "$ROOT/flake.nix"
(cd "$ROOT" && NIX_CONFIG='experimental-features = nix-command flakes' nix flake lock)
echo "pin updated to $rev ($hash)"
