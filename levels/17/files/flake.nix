{
  description = "Level 16: which package holds the flag?";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/@NIXPKGS_REV@";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
      mk = pkgs: name: desc: pkgs.runCommand "pkg-${name}"
        { meta.description = desc; }
        ''
          mkdir -p $out
          printf 'FLAG{%s}\n' "$(printf 'l17:${name}' | sha256sum | cut -c1-16)" > $out/flag
        '';
    in
    {
      packages = forAll (pkgs: {
        alpha = mk pkgs "alpha" "a decoy";
        beta = mk pkgs "beta" "another decoy";
        gamma = mk pkgs "gamma" "THE REAL ONE: this package holds the flag";
        delta = mk pkgs "delta" "also a decoy";
      });
    };
}
