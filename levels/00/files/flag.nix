# Level 00: this file is a program, not a secret. Evaluate it.
let
  words = [ "nix" "evaluates" "expressions" ];
  digest = builtins.hashString "sha256" (builtins.concatStringsSep "-" words);
in
"FLAG{" + builtins.substring 0 16 digest + "}"
