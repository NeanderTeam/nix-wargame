printf ':l puzzle.nix\nanswer (builtins.length (builtins.attrNames zoo))\n' | nix repl 2>&1 | grep -o 'FLAG{[^}]*}'
