# Pinned nixpkgs (nixos-25.05 at the time of writing).
# Usage: import ./pin.nix { }            -> the package set
#        import ./pin.nix { overlays = [ ... ]; }
{ overlays ? [ ], config ? { } }:
import
  (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/@NIXPKGS_REV@.tar.gz";
    sha256 = "@NIXPKGS_HASH@";
  })
{ inherit overlays config; }
