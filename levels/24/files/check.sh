#!/usr/bin/env bash
set -euo pipefail
cand=${1:?usage: ./check.sh /nix/store/...-glibc-...}
r=$(readlink -f result)
[[ $cand =~ ^/nix/store/[0-9a-z]{32}-glibc-[0-9.]+-[0-9]+$ ]] || { echo "not a plain glibc store path" >&2; exit 1; }
nix-store --query --requisites "$r" | grep -Fxq -- "$cand" || { echo "not in the closure of result" >&2; exit 1; }
if nix-store --query --references "$r" | grep -Fxq -- "$cand"; then echo "that is a direct reference" >&2; exit 1; fi
printf 'FLAG{%s}\n' "$(printf 'l24:%s' "$(basename "$cand")" | sha256sum | cut -c1-16)"
