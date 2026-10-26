sed -i -e 's|^ *# TODO 1.*$|          packages = [ pkgs.hello ];|' -e 's|^ *# TODO 2.*$|          LEVEL_TOKEN = "twenty";|' flake.nix
nix develop -c ./check.sh
