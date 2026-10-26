#!/usr/bin/env bash
set -euo pipefail
[[ ${LEVEL_TOKEN:-} == twenty ]] || { echo "LEVEL_TOKEN is '${LEVEL_TOKEN:-}', expected 'twenty'" >&2; exit 1; }
case $(command -v hello || true) in /nix/store/*) ;; *) echo "hello is not from the store" >&2; exit 1 ;; esac
printf 'FLAG{%s}\n' "$(printf 'l20:%s:%s' "$LEVEL_TOKEN" "$(hello --version | head -n1)" | sha256sum | cut -c1-16)"
