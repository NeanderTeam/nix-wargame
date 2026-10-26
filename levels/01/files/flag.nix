{ who, times }:
assert builtins.isString who || throw "`who` must be a string";
assert builtins.isInt times || throw "`times` must be an integer, not ${builtins.typeOf times}";
let
  digest = builtins.hashString "sha256"
    (builtins.concatStringsSep "|" (builtins.genList (_: who) times));
in
"FLAG{" + builtins.substring 0 16 digest + "}"
