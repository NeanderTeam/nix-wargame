#!/usr/bin/env bash
set -euo pipefail
f=${1:?usage: ./check.sh result}
[[ -f $f ]] || { echo "$f is not a regular file" >&2; exit 1; }
[[ $(cat "$f") == "nix builds in a sandbox" ]] || { echo "unexpected content: $(cat "$f")" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l11:%s' "$(basename "$(readlink -f "$f")")" | sha256sum | cut -c1-16)"
