{
  description = "Level 17: override an input from the command line";
  inputs.helper.url = "path:./helper-v1";

  outputs = { self, helper }: {
    lib.flag =
      if helper.version == 2
      then "FLAG{" + builtins.substring 0 16 (builtins.hashString "sha256" "l18:${helper.secret}") + "}"
      else throw "helper is stale (version ${toString helper.version}); try another helper";
  };
}
