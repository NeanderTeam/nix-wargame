sys=$(nix eval --impure --raw --expr builtins.currentSystem)
for n in alpha beta gamma delta; do
  d=$(nix eval --raw ".#packages.$sys.$n.meta.description")
  case $d in *"THE REAL ONE"*) real=$n ;; esac
done
nix build -o result ".#packages.$sys.$real"
cat result/flag
