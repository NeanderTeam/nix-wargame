#!/usr/bin/env bash
set -euo pipefail
d=${PLAY_DIR:-$PWD}
p=$d/profile
[[ -x $p/bin/hello ]] || { echo "hello is not in $p" >&2; exit 1; }
[[ ! -e $p/bin/jq ]] || { echo "jq is still in the profile; did you roll back?" >&2; exit 1; }
[[ -e $d/profile-2-link ]] || { echo "generation 2 never existed" >&2; exit 1; }
[[ $(readlink "$p") == profile-1-link ]] || { echo "current generation is $(readlink "$p"), expected profile-1-link" >&2; exit 1; }
printf 'FLAG{%s}\n' "$(printf 'l26:%s' "$("$p/bin/hello" --version | head -n1)" | sha256sum | cut -c1-16)"
