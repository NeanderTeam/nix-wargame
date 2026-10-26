nix-instantiate --eval --raw --expr '
  let d = import ./defaults.nix; o = import ./overrides.nix;
  in (import ./mk.nix) (d // o // { ports = d.ports ++ o.ports; nested = d.nested // o.nested; })'
