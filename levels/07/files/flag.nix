{ pkgs }:
"FLAG{" + builtins.substring 0 16 (builtins.hashString "sha256" ("lib-" + pkgs.lib.version)) + "}"
