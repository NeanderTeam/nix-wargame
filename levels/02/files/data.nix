{
  note = "Only `answer.flag` matters here.";
  decoy.flag = "FLAG{this-is-a-decoy}";
  answer.flag =
    "FLAG{" + builtins.substring 0 16
      (builtins.hashString "sha256" "the-new-cli-is-experimental") + "}";
}
