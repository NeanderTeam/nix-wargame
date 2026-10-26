# Naive attempts: a path that was never added, and an unrelated file.
./check.sh /nix/store/00000000000000000000000000000000-blob.txt
./check.sh "$(nix-store --store ./store --add check.sh)"
