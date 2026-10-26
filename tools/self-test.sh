#!/usr/bin/env bash
# Offline self-test: level structure rules + CLI behaviour against a fake game.
# Does not need network or a working Nix daemon. Used by `nix flake check` and CI.
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
fails=0
t() { # t "description" command...
  local d=$1
  shift
  if "$@" >"$tmp/out" 2>&1; then echo "ok   $d"; else echo "FAIL $d"; sed 's/^/     /' "$tmp/out"; fails=$((fails + 1)); fi
}
tn() { # expects failure
  local d=$1
  shift
  if "$@" >"$tmp/out" 2>&1; then echo "FAIL $d (expected failure)"; fails=$((fails + 1)); else echo "ok   $d"; fi
}

# ---- 1. structure of the real levels ---------------------------------------
check_level() {
  local d=$1
  [[ -s $d/GOAL.md && -s $d/title && -s $d/tier ]] || { echo "missing GOAL/title/tier in $d"; return 1; }
  [[ $(tr -d '\n' <"$d/flag.sha256") =~ ^[0-9a-f]{64}$ ]] || { echo "bad flag.sha256 in $d"; return 1; }
  local i
  for i in 1 2 3; do [[ -s $d/hints/$i.md ]] || { echo "missing hint $i in $d"; return 1; }; done
  [[ -d $d/files ]] || { echo "missing files/ in $d"; return 1; }
  grep -q 'Network:' "$d/GOAL.md" || { echo "GOAL.md of $d must declare Network:"; return 1; }
  grep -q 'wargame submit' "$d/GOAL.md" || { echo "GOAL.md of $d lacks submit line"; return 1; }
}
n=0
for d in "$ROOT"/levels/[0-9][0-9]; do
  n=$((n + 1))
  t "level $(basename "$d") structure" check_level "$d"
  if [[ -d $ROOT/solutions && -f $ROOT/solutions/README.md && ! -f $ROOT/solutions/$(basename "$d").sh ]] \
    && ! grep -q 'not distributed' "$ROOT/solutions/README.md"; then
    echo "FAIL level $(basename "$d") has no solution"; fails=$((fails + 1))
  fi
  if [[ -f $ROOT/solutions/$(basename "$d").sh && ! -f $ROOT/solutions/$(basename "$d").initial.sh ]]; then
    echo "FAIL level $(basename "$d") has no solutions/NN.initial.sh"; fails=$((fails + 1))
  fi
done
[[ $n -ge 1 ]] || { echo "FAIL no levels found"; fails=$((fails + 1)); }
pin_in_sync() {
  local rev
  rev=$(sed -n 's/^NIXPKGS_REV=//p' "$ROOT/common/pin.env")
  grep -q "github:NixOS/nixpkgs/$rev\"" "$ROOT/flake.nix" || { echo "flake.nix pin differs from common/pin.env ($rev)"; return 1; }
  grep -q "\"rev\": \"$rev\"" "$ROOT/flake.lock" || { echo "flake.lock pin differs from common/pin.env ($rev)"; return 1; }
  grep -q "archive/$rev.tar.gz" "$ROOT/common/pin.env" || { echo "NIXPKGS_URL differs from NIXPKGS_REV"; return 1; }
}
t "nixpkgs pin identical in pin.env, flake.nix and flake.lock" pin_in_sync
no_plain_flags() { ! grep -rEn 'FLAG\{[0-9a-f]{12,}\}' "$ROOT/levels" "$ROOT/docs" "$ROOT/README.md"; }
t "no plaintext flags in the player-visible tree" no_plain_flags

# ---- 2. CLI behaviour on a fake game -----------------------------------------
fake=$tmp/fake
mkdir -p "$fake/common" "$fake/levels/00/files" "$fake/levels/00/hints" "$fake/levels/01/files" "$fake/levels/01/hints"
cp "$ROOT/common/pin.env" "$fake/common/"
for i in 00 01; do
  printf 'title%s\n' "$i" >"$fake/levels/$i/title"
  printf 'Tier\n' >"$fake/levels/$i/tier"
  printf '# Level %s\nGOAL TEXT %s\n' "$i" "$i" >"$fake/levels/$i/GOAL.md"
  printf 'h1\n' >"$fake/levels/$i/hints/1.md"
  printf 'h2\n' >"$fake/levels/$i/hints/2.md"
  printf 'payload\n' >"$fake/levels/$i/files/f.txt"
done
printf 'FLAG{zero}' | sha256sum | cut -d' ' -f1 >"$fake/levels/00/flag.sha256"
printf 'FLAG{one}' | sha256sum | cut -d' ' -f1 >"$fake/levels/01/flag.sha256"

export XDG_STATE_HOME=$tmp/state XDG_CACHE_HOME=$tmp/cache
w() { WARGAME_ROOT=$fake "$ROOT/wargame" "$@"; }

t "status runs" w status
tn "level 01 is locked" w show 01
tn "start 01 is locked" w start 01
t "start 00 prints goal and creates scratch" bash -c "WARGAME_ROOT=$fake $ROOT/wargame start 00 | grep -q 'GOAL TEXT 00' && test -f $tmp/cache/nix-wargame/play/00/f.txt"
t "pin placeholders substituted/common copied" test -f "$tmp/cache/nix-wargame/play/00/pin.env"
t "where prints the scratch dir" bash -c "[ \"\$(WARGAME_ROOT=$fake $ROOT/wargame where 0)\" = $tmp/cache/nix-wargame/play/00 ]"
t "hint 1 then 2" bash -c "WARGAME_ROOT=$fake $ROOT/wargame hint 0 | grep -q h1 && WARGAME_ROOT=$fake $ROOT/wargame hint 0 | grep -q h2"
t "hint exhausted message" bash -c "WARGAME_ROOT=$fake $ROOT/wargame hint 0 | grep -q 'No more hints'"
tn "wrong flag rejected" w submit 0 'FLAG{nope}'
t "right flag accepted (noise tolerated)" bash -c "WARGAME_ROOT=$fake $ROOT/wargame submit 0 'got \"FLAG{zero}\" yes' | grep -q 'Level 00 passed'"
t "level 01 unlocked now" w show 01
echo stale >"$tmp/cache/nix-wargame/play/00/extra.txt"
t "start --fresh recreates scratch" bash -c "WARGAME_ROOT=$fake $ROOT/wargame start 00 --fresh >/dev/null && test ! -e $tmp/cache/nix-wargame/play/00/extra.txt && test -f $tmp/cache/nix-wargame/play/00/f.txt"
t "reset without confirmation keeps progress" bash -c "echo n | WARGAME_ROOT=$fake $ROOT/wargame reset >/dev/null && test -f $tmp/state/nix-wargame/progress"
t "reset --yes removes only the progress file" bash -c "WARGAME_ROOT=$fake $ROOT/wargame reset --yes >/dev/null && test ! -e $tmp/state/nix-wargame/progress && test -d $tmp/cache/nix-wargame/play/00"
t "env prints NIX_CONFIG" bash -c "WARGAME_ROOT=$fake $ROOT/wargame env | grep -q flakes"

echo
if [[ $fails -eq 0 ]]; then echo "self-test: all good"; else echo "self-test: $fails failure(s)"; exit 1; fi
