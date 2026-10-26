export WARGAME_LEAK=yes WARGAME_KEEP=ok; nix-shell --run ./check.sh; nix-shell --pure --run ./check.sh
