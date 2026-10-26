#!/usr/bin/env bash
set -euo pipefail
p=$(readlink -f "${1:?usage: ./check.sh result}")
out=$("$p/bin/greeter")
[[ $out == "overridden from outside, world" ]] || { echo "greeter said: $out" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l21:%s' "$out" | sha256sum | cut -c1-16)"
