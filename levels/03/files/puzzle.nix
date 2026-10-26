rec {
  # Even-numbered animals only. How many are there?
  zoo = builtins.listToAttrs (map
    (i: { name = "animal${toString i}"; value = i; })
    (builtins.filter (i: builtins.bitAnd i 1 == 0) (builtins.genList (i: i) 41)));

  riddle = "How many attributes does `zoo` have? Give that number to `answer`.";

  answer = n:
    if n == builtins.length (builtins.attrNames zoo)
    then "FLAG{" + builtins.substring 0 16 (builtins.hashString "sha256" "repl-${toString n}") + "}"
    else throw "nope, ${toString n} is not the count";
}
