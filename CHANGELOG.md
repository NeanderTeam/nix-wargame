# Changelog (maintainer audit log)

## Audit pass: premises, links, safety, consistency

Tooling
- verify-solutions / verify-initial-states: no user nix.conf, `NIX_CONFIG` unset except for
  levels declaring `Flakes needed: YES` (`--flakes-env` enables it everywhere), dead proxy for
  `Network: no` levels (proves the field), initial attempts must fail unless `# EXPECT-SUCCESS`.
- bump-pin.sh also rewrites flake.nix and refreshes flake.lock; self-test fails if pin.env,
  flake.nix and flake.lock disagree.
- self-test requires `solutions/NN.initial.sh` for every level.

Levels
- 02: GOAL notes that `NIX_CONFIG` must be unset; initial attempt runs with `env -u NIX_CONFIG`.
- 03: `nix repl` is NOT gated behind nix-command (verified); removed the false claim from
  GOAL and hint 1, solution no longer passes the experimental flag.
- 05, 14, 19, 20, 24, 25, 21, 16, 11, 12, 18: documentation links fixed (dead Nix Pills URL
  for fixed-output, wrong Pills numbers for store paths/runtime deps, laziness page, flake output
  schema anchors that do not exist, numbered Pills URLs that avoid redirects).
- 25: now uses a throwaway local store (`--store ./store`) so the real store is untouched;
  GOAL/hints/check/solution rewritten; Network: no (verified behind a dead proxy).
- 17, 18, 19, 20, 28: initial scripts also assert flakes are refused without the feature.
- 00, 01, 07, 08, 17: initial scripts document why a single-command / decoy attempt is used.
- All levels: initial scripts must exit non-zero (premise of GOAL holds) unless marked.

Docs
- README/FAQ: accurate side-effect statement (builds add store paths; `-o` creates gcroots/auto
  symlinks; level 25 uses a local store).
