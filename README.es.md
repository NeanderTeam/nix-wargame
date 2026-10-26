# nix-wargame (resumen en español)

Juego estilo Bandit (OverTheWire) para aprender el gestor de paquetes **Nix**:
29 niveles cortos, una idea por nivel. Cada nivel pide hacer algo real con Nix y
el resultado (evaluación, build, store path, error corregido) es la bandera
`FLAG{...}` que desbloquea el siguiente.

Inicio rápido (sin flakes): `./wargame doctor`, `./wargame start`, `./wargame submit 00 'FLAG{...}'`.
Con flakes: `nix run github:neanderteam/nix-wargame -- start`.

- Las banderas nunca están en texto plano (solo `flag.sha256`); las pistas salen de a una con `wargame hint N`.
- Las soluciones están en `solutions/` (spoilers). Para distribuir sin ellas: `tools/strip-solutions.sh <dir-nuevo>`.
- El bloqueo de niveles es local y de palabra de honor.
- Nada requiere `sudo`, no se hace garbage collection y no se toca tu perfil real.

Documentación completa (en inglés): [README.md](README.md), [docs/](docs/).
