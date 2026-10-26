# nix-wargame

A Bandit-style wargame that teaches the **Nix package manager**. 29 short levels,
one idea each. You get a goal, you do something real in Nix, and the thing you
produce (an evaluation result, a built file, a store path, a fixed build) is
the flag that unlocks the next level.

```
LVL  TIER                  TITLE
00   1 Basics/CLI          first-eval
...
28   9 Boss                boss
```

## Quickstart

You need Nix (multi-user or single-user) and a shell. No root, no system
configuration changes.

```sh
# 1. get the game
nix --extra-experimental-features 'nix-command flakes' run github:neanderteam/nix-wargame -- doctor

# 2. play
nix --extra-experimental-features 'nix-command flakes' run github:neanderteam/nix-wargame -- start

# 3. submit
nix --extra-experimental-features 'nix-command flakes' run github:neanderteam/nix-wargame -- submit 00 'FLAG{...}'
```

No flakes? Clone the repo and use the plain script. Level 00 needs nothing but a
working `nix-instantiate`:

```sh
git clone https://github.com/neanderteam/nix-wargame && cd nix-wargame
./wargame doctor
./wargame start
```

Commands: `status`, `start [N] [--fresh]`, `show N`, `hint N`, `submit N FLAG`,
`where [N]`, `env`, `doctor`, `reset`.

## Tiers

| Tier | Levels | You learn |
|---|---|---|
| 1 Basics/CLI | 00-03 | evaluating, arguments, the new `nix` CLI, the repl |
| 2 Language | 04-07 | syntax errors, laziness, merging/asserts, pinned nixpkgs |
| 3 Shells & ad-hoc | 08-10 | `nix-shell -p`, `shell.nix`, `--pure` |
| 4 Derivations | 11-14 | raw derivations, build phases, reading failures, fixed-output |
| 5 Packaging | 15-16 | `writeShellApplication`, `callPackage` |
| 6 Flakes | 17-20 | outputs, `--override-input`, apps, `nix develop` |
| 7 Overlays/overrides | 21-23 | `.override`, `.overrideAttrs`, overlays |
| 8 Store internals | 24-27 | closures, content addressing, profiles, GC roots |
| 9 Boss | 28 | three earlier lessons in one broken flake |

Full mapping to Nix concepts: [docs/CURRICULUM.md](docs/CURRICULUM.md).

## Flakes in your shell

Flake levels (17, 18, 19, 20, 28) need the `nix-command` and `flakes` experimental
features. The game never edits your Nix config; enable them for your current
shell only:

```sh
eval "$(./wargame env)"
# which is:  export NIX_CONFIG='experimental-features = nix-command flakes'
```

## Safety

- No level needs `sudo` or changes system config (`/etc/nix` is never touched).
- The game never runs garbage collection and never touches your real profile;
  profile levels use `--profile "$PLAY_DIR/profile"`.
- Levels that need the network are marked **Network: YES** in their GOAL and
  only talk to cache.nixos.org and github.com (pinned nixpkgs, ~40 MB the first time).
- Builds add store paths to your normal Nix store (removable later with your own `nix-collect-garbage`;
  the game never runs it). `nix-build -o NAME` also registers a GC-root symlink under
  `/nix/var/nix/gcroots/auto`; delete the `NAME` symlink in the scratch dir to release it.
  Level 25 uses a throwaway local store inside the scratch dir, so the real store is untouched there.
- Work happens in `${XDG_CACHE_HOME:-~/.cache}/nix-wargame/play/NN`; progress is
  `${XDG_STATE_HOME:-~/.local/state}/nix-wargame/progress`.

## Spoiler policy

- Flags are never stored in plaintext. Each level has only `flag.sha256`.
- Hints are revealed one at a time with `wargame hint N`.
- Complete solutions live in `solutions/` (one script per level, loud warning
  inside). Public distributions should not ship it: keep it on a separate branch
  or generate a clean copy with `tools/strip-solutions.sh <new-dir>`.

## Honor system

Level locking is enforced by a local bash script. You can edit the progress
file, read `solutions/`, or compute a flag by hand; nothing stops you. The only
person you cheat is yourself.

## Running it as a class / CTF

- Everyone plays locally (the progress file is theirs). Hand out the spoiler-free copy.
- To track a group, ask for the `wargame status` output, or have players
  submit the flag of a chosen level to your own form. Because flags are
  identical for every player, share them via a private channel only after the
  event, or use a different pin/salt per cohort (see docs/HOW-IT-WORKS.md).
- Self-host: fork, change the owner in the run command, run CI, point students at
  `nix run github:<your-org>/nix-wargame`.
- A recommended pace: 8 levels per 90-minute session, one tier at a time.

## Maintainers

[CONTRIBUTING.md](CONTRIBUTING.md), [docs/LEVEL-DESIGN.md](docs/LEVEL-DESIGN.md),
`tools/verify-solutions.sh`, `tools/verify-initial-states.sh`, `tools/bump-pin.sh`. License: MIT.

Spanish summary: [README.es.md](README.es.md).
