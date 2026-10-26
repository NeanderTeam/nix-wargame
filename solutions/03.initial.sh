# Naive attempt: guess the count. The repl prints the error but itself exits 0,
# so succeed only if a flag was printed.
out=$(printf ':l puzzle.nix\nanswer 0\n' | nix repl 2>&1)
echo "$out"
grep -Eq 'FLAG\{[0-9a-f]{16}\}' <<<"$out"
