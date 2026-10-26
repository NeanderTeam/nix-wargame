#!/usr/bin/env bash
# Scaffold a new level from templates/level/.
# Usage: tools/new-level.sh NN "Tier name" title-slug
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
[[ $# -eq 3 ]] || { echo 'usage: tools/new-level.sh NN "Tier name" title-slug' >&2; exit 1; }
id=$(printf '%02d' "$((10#$1))")
tier=$2
slug=$3
dest=$ROOT/levels/$id
[[ ! -e $dest ]] || { echo "level $id already exists" >&2; exit 1; }
mkdir -p "$dest"
cp -R "$ROOT/templates/level/." "$dest/"
printf '%s\n' "$tier" >"$dest/tier"
printf '%s\n' "$slug" >"$dest/title"
sed -i -e "s/@NN@/$id/g" -e "s/@TITLE@/$slug/g" -e "s/@TIER@/$tier/g" "$dest/GOAL.md"
cat >"$ROOT/solutions/$id.sh" <<SOL
# Solution for level $id. Runs inside the level scratch dir; print the flag on stdout.
echo "TODO"
SOL
cat >"$ROOT/solutions/$id.initial.sh" <<SOL
# Naive first attempt in the UNSOLVED scratch dir; it must not print the real flag.
true
SOL
echo "Created levels/$id and solutions/$id.sh"
echo "Next: write GOAL/hints/files and the solution, then run:"
echo "  tools/verify-solutions.sh --update $id   # writes flag.sha256 from the solution"
echo "  tools/verify-solutions.sh $id"
echo "  tools/verify-initial-states.sh $id"
