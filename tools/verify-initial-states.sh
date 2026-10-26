#!/usr/bin/env bash
# Anti-shortcut check: in the UNSOLVED initial state of every level, nothing the
# player can trivially do may yield the real flag.
#  (a) no file in the fresh scratch dir contains a FLAG{...} whose sha256 matches;
#  (b) the naive attempt in solutions/NN.initial.sh (must exit non-zero unless it has an
#      '# EXPECT-SUCCESS' line) prints
#      no FLAG{...} whose sha256 matches levels/NN/flag.sha256.
# Usage: tools/verify-initial-states.sh [--flakes-env] [NN ...]
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
flakes_env=0
ids=()
for a in "$@"; do [[ $a == --flakes-env ]] && { flakes_env=1; continue; }; ids+=("$(printf '%02d' "$((10#$a))")"); done
if [[ ${#ids[@]} -eq 0 ]]; then
  for d in "$ROOT"/levels/[0-9][0-9]; do ids+=("$(basename "$d")"); done
fi

# Realistic player conditions: no user nix.conf, and flakes enabled only for the
# levels that declare "Flakes needed: YES" (as a player would via `wargame env`).
# --flakes-env enables them for every level (a player who ran `eval "$(wargame env)"`).
export NIX_USER_CONF_FILES=/dev/null
FLAKE_CFG='experimental-features = nix-command flakes'
# Levels that declare "Network: no" run behind a dead proxy to prove it.
DEAD_PROXY=http://127.0.0.1:9

level_env() { # level_env <id>: prints env assignments for env(1)
  local g=$ROOT/levels/$1/GOAL.md
  if [[ $flakes_env -eq 1 ]] || grep -q 'Flakes needed:\*\* YES' "$g"; then
    printf 'NIX_CONFIG=%s\n' "$FLAKE_CFG"
  fi
  if grep -q 'Network:\*\* no' "$g"; then
    printf 'http_proxy=%s\nhttps_proxy=%s\nall_proxy=%s\n' "$DEAD_PROXY" "$DEAD_PROXY" "$DEAD_PROXY"
  fi
}
unset NIX_CONFIG
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
export XDG_STATE_HOME=$tmp/state XDG_CACHE_HOME=$tmp/cache

leaks() { # leaks <want-hash> : stdin is searched for matching flags
  local want=$1 f
  while IFS= read -r f; do
    [[ $(printf '%s' "$f" | sha256sum | cut -d' ' -f1) == "$want" ]] && return 0
  done < <(grep -ao 'FLAG{[^}]*}' || true)
  return 1
}

fail=0
for id in "${ids[@]}"; do
  want=$(cut -d' ' -f1 "$ROOT/levels/$id/flag.sha256")
  play=$tmp/play/$id
  "$ROOT/wargame" _prepare "$id" "$play"
  if grep -ar 'FLAG{' "$play" | leaks "$want"; then
    echo "FAIL $id: flag present in the initial scratch files"; fail=1; continue
  fi
  init=$ROOT/solutions/$id.initial.sh
  if [[ ! -f $init ]]; then
    echo "FAIL $id: missing solutions/$id.initial.sh"; fail=1; continue
  fi
  out=$tmp/$id.log
  mapfile -t envs < <(level_env "$id")
  rc=0
  (cd "$play" && env "${envs[@]}" PLAY_DIR="$play" timeout 600 bash "$init" >"$out" 2>&1) || rc=$?
  # Premise: the naive attempt must FAIL (non-zero) unless the script says '# EXPECT-SUCCESS'.
  if [[ $rc -eq 0 ]] && ! grep -q '^# EXPECT-SUCCESS' "$init"; then
    echo "FAIL $id: the naive attempt unexpectedly succeeded (premise of GOAL.md broken)"; fail=1; continue
  fi
  if grep -q "PREMISE BROKEN" "$out"; then
    echo "FAIL $id: $(grep -m1 "PREMISE BROKEN" "$out")"; fail=1; continue
  fi
  if leaks "$want" <"$out"; then
    echo "FAIL $id: the naive attempt already yields the flag"; fail=1
  else
    echo "ok   $id"
  fi
done
exit "$fail"
