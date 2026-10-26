# Body of the script (writeShellApplication adds the shebang and strict mode).
for t in jq sha256sum; do
  case $(command -v "$t" || true) in
    /nix/store/*) ;;
    *) echo "$t must come from the Nix store (declare it as a runtime input)" >&2; exit 1 ;;
  esac
done
joined=$(jq -r '.words | join("-")' data.json)
printf 'FLAG{%s}\n' "$(printf 'l15:%s' "$joined" | sha256sum | cut -c1-16)"
