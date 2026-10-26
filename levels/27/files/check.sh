#!/usr/bin/env bash
# Reads the output of `nix-store --query --roots <path>` on stdin.
set -euo pipefail
want="$PWD/keepme"
line=$(grep -F -- "$want -> /nix/store/" || true)
[[ -n $line ]] || { echo "no line mentioning $want -> /nix/store/..." >&2; exit 1; }
store=${line##* -> }
printf 'FLAG{%s}\n' "$(printf 'l27:%s' "$(basename "$store")" | sha256sum | cut -c1-16)"
