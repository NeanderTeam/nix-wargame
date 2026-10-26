# Contributing

Thanks for helping. A level is small, but the quality bar is high because
strangers will play it without us around.

## Adding a level

```sh
tools/new-level.sh 29 "6 Flakes" my-level-slug
$EDITOR levels/29/GOAL.md levels/29/hints/*.md levels/29/files/*
$EDITOR solutions/29.sh solutions/29.initial.sh   # initial.sh = naive first attempt, must NOT yield the flag
tools/verify-solutions.sh --update 29   # writes flag.sha256 from your solution
tools/verify-solutions.sh 29
tools/verify-initial-states.sh 29
tools/self-test.sh && shellcheck wargame tools/*.sh
```

Levels are numbered contiguously (`00`..`NN`); inserting in the middle means
renumbering, so prefer appending, or discuss it in an issue first.

## Quality bar

1. **One idea per level.** If the GOAL needs two lessons, split it.
2. **GOAL.md has the fixed sections:** Story, Goal, What you need to know (links to
   official docs, nix.dev, Nix Pills; never the answer), Commands that may help.
   State `Network:` and `Flakes needed:` in the header line.
3. **Three graduated hints:** concept, then tool/option, then nearly the command.
4. **Naive attempt** in `solutions/NN.initial.sh` (what a player would try first). `tools/verify-initial-states.sh` asserts the unsolved state never yields the flag AND that the attempt fails (non-zero exit) as the GOAL claims; add a `# EXPECT-SUCCESS` line with a reason for single-command levels or decoys. Tools run with `NIX_CONFIG` unset (flakes only for levels that declare `Flakes needed: YES`), no user nix.conf, and `Network: no` levels behind a dead proxy; use `--flakes-env` to test with flakes enabled everywhere.
5. **Solution is a script** in `solutions/NN.sh` that runs inside the scratch dir
   (`PLAY_DIR` is exported) and prints exactly the flag. CI runs it.
6. **Reproducible.** Use `./pin.nix` (or the flake input with `@NIXPKGS_REV@`) for
   anything from nixpkgs. Do not depend on the player's channels, `<nixpkgs>` or
   current time.
7. **Safe.** No `sudo`, no edits to system config, no garbage collection of the
   real store, no touching the real profile (use `--profile "$PLAY_DIR/profile"`).
   Network only to cache.nixos.org / github.com for the pinned nixpkgs.
8. **Small downloads.** Prefer tiny packages (`hello`, `jq`). Mention big ones.

## Anti-spoiler rules

- Never commit a flag in plaintext: only `flag.sha256`.
- `cat` of any file in `levels/NN/` must not reveal the flag. The flag must come
  from *doing* the task (evaluation, build output, store path, fixed error).
- A `check.sh` that prints a flag must verify the player's real result first.
- Keep spoilers out of issues/PRs; solutions live only in `solutions/`.
- The threat model is "players who want to learn", not "players who want to cheat":
  see docs/LEVEL-DESIGN.md for what we do and do not defend against.

## Pull requests

Conventional commit messages (`feat(level): ...`, `fix(level-12): ...`). CI must be
green: shellcheck, the offline self-test, and `verify-solutions` for every level.
