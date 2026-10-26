# Naive attempt for a level whose task is a single eval: forget the arguments / wrong types.
nix-instantiate --eval --raw flag.nix; nix-instantiate --eval --raw --argstr who wargame --argstr times 3 flag.nix
