{ writeShellScriptBin, greeting ? "hello" }:
writeShellScriptBin "greeter" ''
  echo "${greeting}, world"
''
