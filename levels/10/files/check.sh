#!/usr/bin/env bash
set -euo pipefail
[[ -z ${WARGAME_LEAK+x} ]] || { echo "WARGAME_LEAK leaked into this shell" >&2; exit 1; }
[[ ${WARGAME_KEEP:-} == ok ]] || { echo "WARGAME_KEEP is '${WARGAME_KEEP:-}', expected 'ok'" >&2; exit 1; }
case $(command -v hello || true) in /nix/store/*) ;; *) echo "hello is not from the store" >&2; exit 1 ;; esac
printf 'FLAG{%s}\n' "$(printf 'l10:%s' "$(hello --version | head -n1)" | sha256sum | cut -c1-16)"
