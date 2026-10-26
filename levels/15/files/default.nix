let
  pkgs = import ./pin.nix { };
in
pkgs.writeShellApplication {
  name = "wargame-tool";
  # TODO: declare the runtime inputs the script needs
  text = builtins.readFile ./tool.sh;
}
