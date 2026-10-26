sed -i -e 's/"friends" \]$/"friends" ];/' \
       -e 's/concatStringSep/concatStringsSep/' \
       -e 's/"}"$/"}";/' broken.nix
nix-instantiate --eval --strict --raw -A flag broken.nix
