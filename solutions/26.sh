nix-env --profile "$PLAY_DIR/profile" -f pin.nix -iA hello
nix-env --profile "$PLAY_DIR/profile" -f pin.nix -iA jq
nix-env --profile "$PLAY_DIR/profile" --rollback
./check.sh
