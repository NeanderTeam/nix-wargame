# SPOILERS AHEAD

**This directory contains the full solution of every level.** If you are playing
the game, stop reading here and close this folder. The learning is in the struggle.

Each `NN.sh` is executed by `tools/verify-solutions.sh` inside a fresh copy of the
level's scratch directory (`PLAY_DIR` is set to it) and must print the flag on stdout.

## For maintainers

A public repository can handle this in two ways:

1. Keep `solutions/` on a separate, private (or at least non-default) branch, or
2. Distribute a spoiler-free copy built with `tools/strip-solutions.sh <new-dir>`.

CI needs the solutions, so run `tools/verify-solutions.sh` on the full tree.
