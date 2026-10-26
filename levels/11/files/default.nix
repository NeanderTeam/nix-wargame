let
  pkgs = import ./pin.nix { };
in
builtins.derivation {
  name = "wargame-10";
  system = pkgs.stdenv.hostPlatform.system;
  builder = "${pkgs.bash}/bin/bash";
  args = [
    "-c"
    ''
      # TODO: write the line "nix builds in a sandbox" into the file $out
    ''
  ];
}
