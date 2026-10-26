export WARGAME_LEAK=yes WARGAME_KEEP=ok
nix-shell --pure --keep WARGAME_KEEP --run ./check.sh
