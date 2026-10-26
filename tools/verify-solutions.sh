#!/usr/bin/env bash
# Maintainer/CI check: for every level, copy it to a temp scratch dir, run
# solutions/NN.sh inside it and assert the produced flag matches flag.sha256.
#
# Usage: tools/verify-solutions.sh [--update] [--flakes-env] [NN ...]
#   --flakes-env  enable nix-command+flakes via NIX_CONFIG for every level
#   --update   (re)write levels/NN/flag.sha256 from the solution output.
#              Only for maintainers creating/bumping a level; review the diff!
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
update=0
flakes_env=0
ids=()
for a in "$@"; do
  case $a in
    --update) update=1 ;;
    --flakes-env) flakes_env=1 ;;
    *) ids+=("$(printf '%02d' "$((10#$a))")") ;;
  esac
done
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

fail=0
for id in "${ids[@]}"; do
  sol=$ROOT/solutions/$id.sh
  if [[ ! -f $sol ]]; then
    echo "FAIL $id: missing solutions/$id.sh"; fail=1; continue
  fi
  play=$tmp/play/$id
  "$ROOT/wargame" _prepare "$id" "$play"
  log=$tmp/$id.log
  mapfile -t envs < <(level_env "$id")
  if ! (cd "$play" && env "${envs[@]}" PLAY_DIR="$play" bash "$sol" >"$log" 2>&1); then
    echo "FAIL $id: solution exited non-zero (log tail below)"; tail -n 15 "$log"; fail=1; continue
  fi
  flag=$(grep -o 'FLAG{[^}]*}' "$log" | tail -n1 || true)
  if [[ -z $flag ]]; then
    echo "FAIL $id: solution printed no FLAG{...}"; tail -n 15 "$log"; fail=1; continue
  fi
  got=$(printf '%s' "$flag" | sha256sum | cut -d' ' -f1)
  if [[ $update -eq 1 ]]; then
    printf '%s\n' "$got" >"$ROOT/levels/$id/flag.sha256"
    echo "UPDATED $id"
    continue
  fi
  want=$(cut -d' ' -f1 "$ROOT/levels/$id/flag.sha256")
  if [[ $got == "$want" ]]; then echo "ok   $id"; else echo "FAIL $id: flag hash mismatch (got $flag)"; fail=1; fi
done
exit "$fail"
