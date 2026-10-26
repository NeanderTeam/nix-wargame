let
  parts = [ "syntax" "errors" "are" "friends" ]
  joined = builtins.concatStringSep "-" parts;
in
{
  flag = "FLAG{" + builtins.substring 0 16 (builtins.hashString "sha256" joined) + "}"
  note = "fix me";
}
