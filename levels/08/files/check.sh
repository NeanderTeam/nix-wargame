#!/usr/bin/env bash
# Reads one line on stdin and turns it into a flag. Nothing to see here.
set -euo pipefail
read -r line
case $line in
  *"GNU Hello"*) ;;
  *) echo "that does not look like the first line of 'hello --version'" >&2; exit 1 ;;
esac
printf 'FLAG{%s}\n' "$(printf 'l08:%s' "$line" | sha256sum | cut -c1-16)"
