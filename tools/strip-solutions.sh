#!/usr/bin/env bash
# Create a spoiler-free copy of the wargame in a NEW directory.
# Never deletes or modifies anything in place.
# Usage: tools/strip-solutions.sh <new-dir>
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
dest=${1:?usage: tools/strip-solutions.sh <new-dir>}

if [[ -e $dest ]]; then
  echo "error: $dest already exists; refusing to overwrite" >&2
  exit 1
fi
mkdir -p -- "$dest"
dest=$(cd "$dest" && pwd)
if [[ $dest == "$ROOT" || $dest == "$ROOT"/* ]]; then
  echo "error: destination must be outside the source tree" >&2
  rmdir -- "$dest" 2>/dev/null || true
  exit 1
fi

# Copy everything except solutions, the verifier (needs them), VCS data and local junk.
(cd "$ROOT" && tar --exclude=./solutions --exclude=./.git --exclude=./result \
  --exclude=./tools/verify-solutions.sh --exclude=./tools/verify-initial-states.sh -cf - .) | (cd "$dest" && tar -xf -)

mkdir -p "$dest/solutions"
cat >"$dest/solutions/README.md" <<'README'
# Solutions are not distributed with this copy

This is the spoiler-free distribution of nix-wargame. The maintainers keep the
solutions elsewhere. Use `wargame hint N` when you are stuck.
README
echo "Spoiler-free copy written to $dest"
