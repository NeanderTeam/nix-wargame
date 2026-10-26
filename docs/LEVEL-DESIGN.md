# Level design

## Principles

1. One idea per level; the GOAL states the *result*, never the method.
2. The flag is the output of doing the task, not a file to read.
3. Reproducible: pinned nixpkgs, no clocks, no host assumptions.
4. Safe: no sudo, no system config, no real-profile or real-store mutation beyond
   normal builds.

## Flag mechanisms used

| Mechanism | Example levels |
|---|---|
| Evaluation result of an expression | 00, 01, 02, 03, 05, 06, 07 |
| Error to fix, then evaluate/build again | 04, 13, 14, 19, 28 |
| Content of a build output | 11, 12, 15, 16, 21, 22, 23 |
| Tool output inside an environment | 08, 09, 10, 20 |
| Value reachable only through an override | 18, 28 |
| Store path property | 24, 25, 27 |
| State of a profile | 26 |

## Threat model

We defend against: grepping the repo for flags, `cat`-ing a level file, and
accidental spoilers in the player-visible tree (checked by `tools/self-test.sh`).

We do **not** defend against a player who reads `check.sh`, recomputes a hash with
`sha256sum`, edits the progress file or opens `solutions/`. That is why the game is
honor-system and why the flag recipes are in the open: the learning is the work.

## Writing a level

Follow CONTRIBUTING.md. Checklist:

- [ ] `GOAL.md` has Story / Goal / What you need to know / Commands, plus
      `Network:` and `Flakes needed:`.
- [ ] Hints go concept -> option -> near-command.
- [ ] The initial state of the scratch dir really fails (or is incomplete):
      add `solutions/NN.initial.sh` and run `tools/verify-initial-states.sh NN`.
- [ ] `solutions/NN.sh` prints exactly one flag and works on a clean scratch dir.
- [ ] Salt strings are level-specific (`lNN:`).
- [ ] Nothing in `files/` reveals the flag when printed.

## Style of `check.sh`

Fail with a one-line explanation on stderr and exit non-zero, never print the flag
unless the real result is validated. Do not use tools beyond bash + coreutils + nix.
