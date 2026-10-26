{
  description = "nix-wargame: learn the Nix package manager by capturing flags";

  # Same pin the levels use (see common/pin.env). Bump with tools/bump-pin.sh.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/ac62194c3917d5f474c1a844b6fd6da2db95077d";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAll (pkgs: {
        default = pkgs.writeShellApplication {
          name = "wargame";
          runtimeInputs = with pkgs; [ coreutils gnugrep gnused findutils ];
          text = ''
            export WARGAME_ROOT=${self}
            exec ${self}/wargame "$@"
          '';
        };
      });

      apps = forAll (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.system}.default}/bin/wargame";
        };
      });

      devShells = forAll (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [ shellcheck jq coreutils gnugrep gnused findutils ];
        };
      });

      checks = forAll (pkgs: {
        self-test = pkgs.runCommand "wargame-self-test"
          {
            nativeBuildInputs = with pkgs; [ bash coreutils gnugrep gnused findutils shellcheck ];
          }
          ''
            cp -r ${self} src
            chmod -R u+w src
            patchShebangs src
            cd src
            shellcheck wargame tools/*.sh
            bash tools/self-test.sh
            touch $out
          '';
      });
    };
}
