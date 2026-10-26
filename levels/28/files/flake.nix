{
  description = "Boss: three bugs, one flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/@NIXPKGS_REV@";
  inputs.data.url = "path:./data-v1";

  outputs = { self, nixpkgs, data }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      overlay = final: prev: {
        boss-tool = final.callPackage ./boss-tool.nix { payload = data.payload; };
      };
      forAll = f: nixpkgs.lib.genAttrs systems (system:
        f (import nixpkgs { inherit system; overlays = [ overlay ]; }));
    in
    {
      overlays.default = overlay;
      packages = forAll (pkgs: { default = pkgs.boss-tool; });
      apps = forAll (pkgs: {
        default = {
          program = "${pkgs.boss-tool}/bin/boss-tool";
        };
      });
    };
}
