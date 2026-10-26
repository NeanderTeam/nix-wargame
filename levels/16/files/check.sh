#!/usr/bin/env bash
set -euo pipefail
p=$(readlink -f "${1:?usage: ./check.sh result}")
out=$("$p/bin/greeter")
[[ $out == "nix, wargame!" ]] || { echo "greeter said: $out" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l16:%s' "$out" | sha256sum | cut -c1-16)"
