rec {
  boom = throw "never evaluate me";
  items = [ (throw "item a") (abort "item b") 1 2 ];
  count = builtins.length items;
  flag = "FLAG{" + builtins.substring 0 16 (builtins.hashString "sha256" "lazy-${toString count}") + "}";
}
