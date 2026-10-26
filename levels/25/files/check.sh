#!/usr/bin/env bash
set -euo pipefail
p=${1:?usage: ./check.sh /nix/store/...-blob.txt}
[[ $p =~ ^/nix/store/[0-9a-z]{32}-blob\.txt$ ]] || { echo "expected /nix/store/<hash>-blob.txt" >&2; exit 1; }
real=$PWD/store$p
[[ -f $real ]] || { echo "$real not found: add the file to a local store rooted at ./store" >&2; exit 1; }
cmp -s "$real" blob.txt || { echo "content differs from blob.txt" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l25:%s' "$(basename "$p")" | sha256sum | cut -c1-16)"
