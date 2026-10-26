# Curriculum

| Lvl | Title | Nix concept | Main tool / construct |
|---|---|---|---|
| 00 | first-eval | evaluation vs building | `nix-instantiate --eval` |
| 01 | arguments | functions as files, typed arguments | `--arg`, `--argstr` |
| 02 | new-cli | experimental features, unified CLI | `nix eval`, `--extra-experimental-features` |
| 03 | repl | interactive exploration | `nix repl`, `:l`, builtins |
| 04 | syntax-errors | reading evaluation errors | `let`, `;`, builtins |
| 05 | laziness | lazy evaluation | `-A`, `--strict`, `throw` |
| 06 | merge-and-assert | `//` vs deep merge, `++`, assertions | `assert`, `import` |
| 07 | pinned-nixpkgs | reproducible nixpkgs | `fetchTarball`, `lib` |
| 08 | ad-hoc-shell | ad-hoc environments | `nix-shell -p`, `-I` |
| 09 | shell-nix | declarative dev environments | `mkShell` |
| 10 | pure-shell | environment purity | `nix-shell --pure`, `--keep` |
| 11 | raw-derivation | the derivation primitive | `builtins.derivation`, `$out` |
| 12 | build-phases | stdenv phases, shebang patching | `mkDerivation`, `installPhase` |
| 13 | fix-the-build | reading build failures | `nix-build`, `nix log` |
| 14 | fixed-output | fixed-output derivations, hashes | `outputHash`, `fakeHash` |
| 15 | shell-application | trivial builders, runtime deps | `writeShellApplication` |
| 16 | callpackage | dependency injection | `callPackage` |
| 17 | flake-outputs | flake schema, inspection | `nix flake show`, `nix eval`, `nix build` |
| 18 | override-input | inputs and lock | `--override-input`, `path:` refs |
| 19 | flake-app | flake apps | `nix run`, `apps.<system>` |
| 20 | flake-devshell | flake dev shells | `nix develop`, `devShells` |
| 21 | override | argument overrides | `.override` |
| 22 | override-attrs | attribute overrides, hooks | `.overrideAttrs`, `postInstall` |
| 23 | overlay | overlays | `final: prev:` |
| 24 | closure | runtime dependencies | `nix-store -q --references/-R` |
| 25 | content-address | store paths | `nix-store --add` |
| 26 | profiles | generations and rollback | `nix-env --profile` |
| 27 | gc-roots | garbage collector roots | `nix-build -o`, `--query --roots` |
| 28 | boss | tiers 5, 6 and 7 combined | everything above |

## Deliberately out of scope

NixOS modules, Home Manager, direnv integration, cross-compilation, and
`flake-parts`. They are natural follow-up levels: see CONTRIBUTING.md.
