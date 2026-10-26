{
  description = "Level 18: fix the app";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/@NIXPKGS_REV@";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      apps = forAll (pkgs: {
        default = {
          program = "${pkgs.writeShellScript "flag-printer" ''
            printf 'FLAG{%s}\n' "$(printf 'l19:flake-apps' | ${pkgs.coreutils}/bin/sha256sum | ${pkgs.coreutils}/bin/cut -c1-16)"
          ''}";
        };
      });
    };
}
