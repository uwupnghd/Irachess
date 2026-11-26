# Licencias y cumplimiento de la GPL

## Por qué IraChess es GPL-3.0

Stockfish, `multistockfish`, `dartchess` y `chessground` son GPL-3.0 y se enlazan en el binario. Por tanto **toda la app se distribuye bajo GPL-3.0** ([LICENSE](../LICENSE)).

## Cómo se cumple

| Obligación | Cómo |
|------------|------|
| Texto de la licencia | `LICENSE` en la raíz del repositorio. |
| Avisos dentro de la app | Ajustes → Acerca de IraChess → Licencias de terceros: muestra la GPL de IraChess, Stockfish, aperturas, problemas y piezas (`lib/app/licenses.dart`) más las licencias de todos los paquetes Dart. Incluye el aviso de «sin garantía». |
| Código fuente correspondiente | Repositorio público + **una etiqueta git por versión publicada** (p. ej. `v1.0.0` = exactamente lo compilado). La pantalla «Acerca de» enlaza al código. |
| Sin restricciones añadidas | Sin DRM ni SDKs propietarios enlazados (la sincronización usa Supabase por REST, sin SDK). |

Antes de publicar una versión: `git tag v1.x.y && git push --tags`, y confirmar que el repositorio es público.

## Recursos de terceros

| Recurso | Origen | Licencia |
|---------|--------|----------|
| Stockfish 19 (móvil, red *light* de ~1 MB) | `multistockfish` (Lichess) | GPL-3.0 |
| Stockfish (escritorio) | Binario oficial que instala el usuario | GPL-3.0 |
| stockfish.js lite (web, preparado) | `web/engine/` (npm `stockfish`, Nathan Rugg) | GPL-3.0 (`web/engine/COPYING.txt`) |
| Libro de aperturas ECO | `lichess-org/chess-openings` → `assets/openings.tsv` | CC0 |
| Problemas | Base de puzzles de Lichess → `assets/puzzles/base.csv`, `puzzle_packs/` | CC0 |
| Piezas | Solo cburnett y merida (GPLv2+), chessnut (Apache-2.0), fantasy/spatial/celtic (MIT) y rhosgfx (CC0) | Compatibles con GPL-3.0 |
| Logotipo, colores de tablero y clasificaciones | Propios de IraChess | GPL-3.0 |

Los conjuntos de piezas CC BY-NC-SA que incluye `chessground` (staunty, california, maestro, etc.) **no se ofrecen** en la app (`allowedPieceSets` en `lib/core/settings/settings.dart`).

No se usa ninguna marca, texto, icono, sonido ni color de Chess.com: la paleta de clasificaciones y los tableros son originales.

## Tiendas

- **Google Play y F-Droid**: compatibles si se cumple lo anterior. F-Droid exige compilar desde el código fuente; la descarga de la red NNUE durante la compilación de `multistockfish` puede requerir una receta específica.
- **App Store**: la FSF considera los términos de Apple incompatibles con la GPL (caso VLC, 2011). En la práctica hay apps GPL con Stockfish publicadas (como la app de Lichess), y solo los titulares del copyright podrían reclamar. **Consulta con un abogado antes de publicar en iOS.** Esto no es asesoramiento legal.
- Vender la app está permitido por la GPL, pero hay que seguir ofreciendo el código fuente.
