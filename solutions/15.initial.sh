# Premise: a player's shell has no jq/sha256sum from the Nix store on PATH.
# CI and `nix develop` put them there, so strip /nix/store entries when running the tool.
nix-build -o result && PATH=$(printf %s "$PATH" | tr ':' '\n' | grep -v '^/nix/store' | paste -sd:) result/bin/wargame-tool
