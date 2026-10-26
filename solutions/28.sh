sed -i 's|^        default = {$|        default = {\n          type = "app";|' flake.nix
sed -i 's|^{ writeShellApplication, payload }:|{ writeShellApplication, jq, coreutils, payload }:|; s|^  name = "boss-tool";|  name = "boss-tool";\n  runtimeInputs = [ jq coreutils ];|' boss-tool.nix
nix run --override-input data path:./data-v2 .
