{ writeShellApplication, payload }:
writeShellApplication {
  name = "boss-tool";
  excludeShellChecks = [ "SC2050" ]; # payload is interpolated at build time
  text = ''
    for t in jq sha256sum; do
      case $(command -v "$t" || true) in
        /nix/store/*) ;;
        *) echo "$t must come from the Nix store" >&2; exit 1 ;;
      esac
    done
    if [ "${payload}" != "fresh" ]; then
      echo "payload is '${payload}': stale data, the boss wants fresh data" >&2
      exit 1
    fi
    word=$(echo '{"w":"boss-defeated"}' | jq -r .w)
    printf 'FLAG{%s}\n' "$(printf 'l28:%s:%s' "$word" "${payload}" | sha256sum | cut -c1-16)"
  '';
}
