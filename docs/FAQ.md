# FAQ

**Do I need flakes enabled?** Not until level 17. `eval "$(./wargame env)"` enables
them for the current shell only.

**It says `experimental Nix feature 'nix-command' is disabled`.** That is level 02's
point. Use `--extra-experimental-features nix-command` or `eval "$(./wargame env)"`.

**A level downloads a lot / fails offline.** Levels marked Network: YES fetch the
pinned nixpkgs (~40 MB) and small packages from cache.nixos.org. Run
`./wargame doctor` to check connectivity.

**Will this change my system?** No config edits, no sudo, no garbage collection, no
use of your real profile. Builds add store paths to your normal
store, which a `nix-collect-garbage` that you run yourself can remove later. Level 25
uses a throwaway local store inside the scratch dir.

**I broke a level's files.** `./wargame start N --fresh`.

**I want to start over.** `./wargame reset`. It only deletes the progress file.

**Can I skip a level?** Not with the CLI (honor system: you can edit the progress file).

**Flag rejected?** Copy the whole `FLAG{...}`; for builds make sure you ran the
final build, not an earlier failed one.

**The pin is outdated / a level rotted.** Open a "Level bug" issue without spoilers.

**Does it work on macOS / aarch64?** Level logic is system-neutral (it uses
`builtins.currentSystem`/`stdenv.hostPlatform.system`), but it is only routinely
verified on x86_64-linux.
