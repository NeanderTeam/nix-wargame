#!/usr/bin/env bash
set -euo pipefail
p=$(readlink -f "${1:?usage: ./check.sh result}")
out=$("$p/bin/wargame-hello")
[[ $out =~ ^wargame-hello:\ GNU\ hello\ [0-9][0-9.]*$ ]] || { echo "unexpected output: $out" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l23:%s' "$out" | sha256sum | cut -c1-16)"
