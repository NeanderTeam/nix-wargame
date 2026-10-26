sed -i 's|^.*# TODO: declare.*$|  runtimeInputs = [ pkgs.jq pkgs.coreutils ];|' default.nix
nix-build -o result >/dev/null
result/bin/wargame-tool
