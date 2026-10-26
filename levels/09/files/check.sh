#!/usr/bin/env bash
set -euo pipefail
command -v hello >/dev/null || { echo "hello is not on PATH" >&2; exit 1; }
[[ ${LEVEL_TOKEN:-} == nine ]] || { echo "LEVEL_TOKEN is '${LEVEL_TOKEN:-}', expected 'nine'" >&2; exit 1; }
case $(command -v hello) in /nix/store/*) ;; *) echo "hello does not come from the store" >&2; exit 1 ;; esac
printf 'FLAG{%s}\n' "$(printf 'l09:%s:%s' "$LEVEL_TOKEN" "$(hello --version | head -n1)" | sha256sum | cut -c1-16)"
