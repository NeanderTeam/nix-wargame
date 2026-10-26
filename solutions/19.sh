sed -i 's|^        default = {$|        default = {\n          type = "app";|' flake.nix
nix run .
