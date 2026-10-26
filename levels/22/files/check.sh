#!/usr/bin/env bash
set -euo pipefail
p=$(readlink -f "${1:?usage: ./check.sh result}")
[[ $p == *-demo-2.0 ]] || { echo "store path name is $(basename "$p"), expected ...-demo-2.0" >&2; exit 1; }
[[ $(cat "$p/share/note") == "patched via overrideAttrs" ]] || { echo "share/note missing or wrong" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l22:%s' "$(basename "$p")" | sha256sum | cut -c1-16)"
