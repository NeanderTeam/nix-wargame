#!/usr/bin/env bash
set -euo pipefail
p=$(readlink -f "${1:?usage: ./check.sh result}")
exe=$p/bin/greeter
[[ -x $exe ]] || { echo "$exe missing or not executable" >&2; exit 1; }
[[ $("$exe") == "hello from phase" ]] || { echo "wrong output: $("$exe")" >&2; exit 1; }
case $(head -n1 "$exe") in
  '#!/nix/store/'*) ;;
  *) echo "shebang is '$(head -n1 "$exe")', expected a /nix/store path" >&2; exit 1 ;;
esac
printf 'FLAG{%s}\n' "$(printf 'l12:%s' "$(basename "$p")" | sha256sum | cut -c1-16)"
