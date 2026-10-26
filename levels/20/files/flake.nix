{
  description = "Level 20: a flake devShell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/@NIXPKGS_REV@";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAll (pkgs: {
        default = pkgs.mkShell {
          # TODO 1: make `hello` available
          # TODO 2: export LEVEL_TOKEN="twenty"
        };
      });
    };
}
