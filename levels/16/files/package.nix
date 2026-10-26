{ writeShellScriptBin
, greeting ? "hi"
, target
}:
writeShellScriptBin "greeter" ''
  echo "${greeting}, ${target}!"
''
