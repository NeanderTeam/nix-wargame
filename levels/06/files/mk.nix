cfg:
assert cfg.mode == "ship" || throw "mode must be 'ship', got '${cfg.mode}'";
assert cfg.ports == [ 80 443 ] || throw "ports must be [ 80 443 ], got ${builtins.toJSON cfg.ports}";
assert cfg.nested.a == 10 || throw "nested.a must come from overrides.nix";
assert (cfg.nested.b or null) == 2 || throw "nested.b from defaults.nix was lost: is your merge too shallow?";
"FLAG{" + builtins.substring 0 16 (builtins.hashString "sha256" (builtins.toJSON cfg)) + "}"
