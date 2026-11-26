# IraChess

Aplicación Flutter para **aprender de tus propias partidas de ajedrez**: analiza cada jugada con Stockfish, te explica en lenguaje sencillo qué era mejor y por qué, identifica la apertura y en qué jugada saliste de la teoría, y te entrena con problemas (también sin conexión) y con un modo Visión de coordenadas.

Software libre bajo **GPL-3.0** (ver [LICENSE](LICENSE) y [docs/LICENCIAS.md](docs/LICENCIAS.md)).

## Funciones

| Área | Qué hace |
|------|----------|
| Partidas | Pegar o abrir PGN (con variantes, comentarios y relojes), importar de **Lichess** y **Chess.com** con tu usuario público, o **jugar contra el motor** (8 niveles) y analizar después. |
| Análisis | Stockfish 19 en segundo plano (rápido / normal / profundo), cancelable y con caché por posición. Clasificación: Brillante, Genial, Teoría, Mejor, Excelente, Buena, Imprecisión, Omisión, Error, Error grave. Mejor jugada + 2 alternativas. Explicación con motivos tácticos (pieza colgada, horquilla, clavada, ataque descubierto, mate en N). Flechas (tu jugada vs. la mejor), barra y gráfico de evaluación, «Pruébalo tú». |
| Resumen | Precisión de cada bando, conteo por clase, rendimiento por fase, momentos críticos, apertura + salida de teoría y qué practicar. |
| Tabla | Número, jugada, evaluación, clase, mejor alternativa y tiempo usado; filtros (mis errores, errores graves, por fase); tocar una fila mueve el tablero. Exportar PGN anotado. |
| Problemas | 1.425 problemas de Lichess (CC0) incluidos + 35 paquetes descargables por tema y nivel; pistas, solución, rating Glicko-2, rachas; **problemas de mis errores**. Todo funciona en modo avión. |
| Visión | Toca la casilla que aparece: 30 s, 60 s o 20 aciertos; blancas o negras; con o sin coordenadas; récord y casillas más falladas. |
| Progreso | Precisión por partida, rating de problemas, aperturas (V/T/D y precisión), tipos de error, racha diaria y objetivo diario. |
| Cuenta | Opcional. Sin registro todo queda en el dispositivo; con Supabase se sincroniza sin duplicados. |

Español por defecto e inglés; tema claro/oscuro; 4 tableros y 7 juegos de piezas de licencia libre; modo daltónico; navegación inferior en móvil y barra lateral en tableta/escritorio.

## Requisitos

- Flutter **3.50** o superior (Dart 3.14).
- Android: SDK de Android (la compilación descarga el NDK y la red NNUE de Stockfish).
- Linux (escritorio): `sudo apt install libgtk-3-dev libsqlite3-dev stockfish`.
- Windows (escritorio): Visual Studio o Build Tools con «Desarrollo para el escritorio con C++», el **Modo de desarrollador** de Windows activado y el ejecutable de Stockfish (ver abajo).
- macOS (escritorio): Xcode y el ejecutable de Stockfish.

## Ejecutar

```bash
flutter pub get
```

```bash
flutter run -d android
```

```bash
flutter run -d linux
```

```bash
flutter build windows --release
```

En Windows la app queda en `build\windows\x64\runner\Release\irachess.exe`; copia `stockfish.exe` en la subcarpeta `engine` de esa misma carpeta.

### Stockfish en escritorio

En Android/iOS el motor va dentro de la app (`multistockfish`). En escritorio IraChess busca, por orden: la variable `IRACHESS_STOCKFISH`, `engine/stockfish[.exe]` junto al ejecutable de la app, el `PATH` y `/usr/games/stockfish`. Descarga el binario oficial desde https://stockfishchess.org/download/ y colócalo en una de esas rutas.

### Compilar para publicar

```bash
flutter build apk --release --split-per-abi
```

```bash
flutter build linux --release
```

El APK se firma con la clave de depuración mientras no configures la tuya (`android/app/build.gradle.kts`).

### Sincronización opcional

1. Crea un proyecto en Supabase (el plan gratuito basta) y ejecuta [supabase/schema.sql](supabase/schema.sql) en su editor SQL.
2. Activa el acceso por email con código (Auth → Providers → Email).
3. Compila con tus claves públicas:

```bash
flutter run --dart-define=SUPABASE_URL=https://TU-PROYECTO.supabase.co --dart-define=SUPABASE_ANON_KEY=TU_CLAVE_ANON
```

Sin estas claves, la app funciona igual y la sección de cuenta indica que no está configurada.

### Paquetes de problemas

La app descarga los paquetes de `puzzle_packs/` desde `https://raw.githubusercontent.com/uwupnghd/irachess/main/puzzle_packs/` (el repositorio debe ser público y la rama fusionada en `main`). Para otro alojamiento: `--dart-define=PUZZLE_PACKS_URL=https://.../`. Para regenerarlos:

```bash
curl -O https://database.lichess.org/lichess_db_puzzle.csv.zst
```

```bash
zstd -dc lichess_db_puzzle.csv.zst | dart run tool/build_puzzles.dart
```

El libro de aperturas se regenera con `dart run tool/build_openings.dart`.

## Pruebas y análisis estático

```bash
flutter analyze
```

```bash
flutter test
```

Incluye pruebas unitarias (reglas y tablas, clasificación, precisión, aperturas, PGN, tácticas, Glicko-2, Visión, rachas), de widgets (tabla de jugadas, resumen, tablero de Visión, navegación adaptable, bienvenida) y de integración (análisis completo con motor simulado y caché, sincronización entre dos dispositivos). La prueba con Stockfish real se ejecuta si hay un `stockfish` instalado.

## Estructura

```
lib/
  app/        arranque, router, navegación adaptable, licencias
  core/       ajedrez (dartchess), motor UCI (móvil/escritorio/web), BD Drift, red, ajustes, UI común
  features/   games · analysis · openings · puzzles · vision · progress · play · sync · settings · onboarding
assets/       libro ECO, problemas base, logotipo
tool/         generadores de aperturas y problemas
supabase/     esquema SQL de la sincronización
docs/         propuesta técnica, estado por fases, licencias
```

Estado detallado, decisiones y pendientes: [docs/ESTADO.md](docs/ESTADO.md).
