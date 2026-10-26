# EXPECT-SUCCESS
# Single-command level: there is no meaningful "before" state; the task IS the evaluation.
# We only assert that merely reading the files does not reveal the flag.
cat flag.nix >/dev/null; ls
