# Estado del proyecto

Fecha: 2026-11-26. Rama: `claude/focused-albattani-cmxhkn`.

## Resumen por fases

| Fase | Estado | Qué incluye |
|------|--------|-------------|
| 1 · MVP de análisis | ✅ Hecha | Proyecto Flutter, tablero, PGN (pegar/archivo), Stockfish fuera del hilo de UI, clasificación, explicaciones, aperturas y salida de teoría, tabla, resumen, PGN anotado. |
| 2 · Problemas | ✅ Hecha | Lote base offline, paquetes descargables (espacio usado, borrar), rating Glicko-2, pistas, rachas, problemas de mis errores. |
| 3 · Visión, progreso, importación | ✅ Hecha | Modo Visión, panel de progreso, Lichess y Chess.com, jugar contra el motor. |
| 4 · Pulido y cuentas | ✅ Hecha, salvo lo indicado abajo | Bienvenida, i18n completa es/en, tema claro/oscuro, modo daltónico, `Semantics`, licencias en la app, cuenta opcional y sincronización. |

## Plataformas

| Plataforma | Estado |
|------------|--------|
| Linux (escritorio) | Compilada y ejecutada aquí: importar PGN → analizar con Stockfish real → tabla, resumen, flechas y explicaciones. |
| Android | APK de *release* compilado aquí para arm64 (`flutter build apk --release --split-per-abi`): 43,5 MB. **No probado en un dispositivo ni en un emulador** (este entorno no tiene KVM): falta medir el «< 1 minuto» en un móvil de gama media. |
| Windows / macOS | Mismo código que Linux; no compilados (no hay esos sistemas aquí). Necesitan el ejecutable de Stockfish (README). |
| iOS | Configurado (nombre, iconos) pero **no compilado** (requiere macOS + Xcode). Revisar el tema legal antes de publicar ([LICENCIAS.md](LICENCIAS.md)). |
| Web | **Bloqueada por ahora.** `flutter build web --wasm` siempre compila también una versión JavaScript de respaldo, y `dartchess` usa enteros de 64 bits que dart2js no admite. Se aplica la decisión D2: la web queda para cuando Flutter permita compilar solo Wasm o `dartchess` admita JavaScript. Ya están preparados el motor web (`web/engine/`, Stockfish 19 lite) y el canal UCI por Web Worker; faltarían `web/sqlite3.wasm` (descargable de las *releases* de `sqlite3.dart` 3.9.2) y `web/drift_worker.js` (`dart compile js -O4 tool/drift_worker.dart -o web/drift_worker.js`). |

## Verificación realizada

- `flutter analyze`: sin avisos, con `strict-casts`, `strict-inference` y `strict-raw-types`.
- `flutter test`: unitarias, de widgets y de integración (ver README).
- Stockfish real (Linux): 8 posiciones en 3,3 s con el preset Normal (~0,4 s por posición, 2 hilos) → una partida de 40 jugadas en ~35 s.
- Importadores probados contra las APIs reales de Lichess y Chess.com (usuarios públicos, usuario inexistente).
- Sincronización probada con dos bases de datos y un servidor simulado con la semántica de PostgREST: sin duplicados, gana la última escritura y los borrados se propagan. **No probada contra un Supabase real** (no se crearon cuentas ni servicios para no generar gastos).

## Tamaño de instalación (APK arm64 de 43,5 MB)

| Parte | Tamaño |
|-------|--------|
| Motor Flutter (`libflutter.so`) | 11,3 MB |
| Código de la app (`libapp.so`) | 8,9 MB |
| Piezas y tableros de `chessground` (todos los conjuntos, aunque la app solo ofrece 7) | 13,0 MB |
| Stockfish: variante *light* (la que se usa) 2,7 MB + variantes *chess* y *variant* que `multistockfish` incluye sin usarse 3,4 MB | 6,1 MB |
| SQLite | 1,8 MB |
| Libro ECO + 1.425 problemas | 0,6 MB |

Google Play entrega la descarga comprimida y por arquitectura, así que la descarga real es menor. Reducirlo de verdad exige quitar los recursos de `chessground` y las variantes de Stockfish que no se usan (requiere bifurcar esos paquetes).

## Decisiones y desviaciones respecto a la propuesta

1. **Sin CI**, por petición tuya.
2. **Web aplazada** (decisión D2, ver arriba).
3. **Modelo de datos más simple**: el análisis de cada jugada se guarda como JSON dentro de `game_analyses.report` (no hay tabla `move_analyses`); los temas de problemas son una columna de texto consultada con `LIKE`; los fallos de Visión van como JSON. Para el volumen de un usuario es suficiente y evita tablas y migraciones.
4. **Paquetes de problemas** en el propio repositorio (`puzzle_packs/`, 1,9 MB) servidos desde `raw.githubusercontent.com`, en lugar de GitHub Releases: desde aquí no puedo crear *releases*. Funciona cuando la rama esté en `main` y el repositorio sea público; la URL se puede cambiar con `PUZZLE_PACKS_URL`.
5. **Sonidos**: se usa el clic del sistema (`SystemSound`), activable. En escritorio puede no sonar. No se añadieron archivos de audio propios.
6. **Tipografía**: la del sistema (Roboto en Android) en lugar de Inter, para no empaquetar fuentes.
7. **Sincronización** por REST (PostgREST + GoTrue) sin el SDK de Supabase: menos dependencias y nada propietario. Se sincronizan partidas, intentos de problemas y sesiones de Visión. No se sincronizan los análisis (se recalculan con caché) ni los ajustes. Los intentos de «problemas de mis errores» no se trasladan entre dispositivos (su id depende de la partida local).
8. **Explicaciones** por reglas, sin IA ni conexión: solo se menciona una táctica si el detector la confirma; si no, se describe la caída de evaluación y la idea de la mejor jugada.
9. **Notación en español** (C, A, T, D, R) cuando el idioma es español; el PGN exportado mantiene la notación estándar inglesa.
10. **Escala de clasificación**: incluye «Genial» y «Omisión» (D3). En la UI cada clase lleva su símbolo de ajedrez (!!, !, ★, ✓✓, ✓, ?!, ✗, ?, ??) además del color.
11. **Rating de problemas**: usar una pista o fallar un intento cuenta como no resuelto para el rating.
12. **Identificador de la app**: `app.irachess.irachess` (generado por `flutter create --org app.irachess`). Cámbialo antes de publicar si quieres otro.
13. **Pruébalo tú** acepta la mejor jugada o cualquiera de las 3 del motor que esté a menos de 2 puntos de probabilidad.

## Pendiente / siguientes pasos

- Probar en un Android real y medir tiempo de análisis y batería; ajustar `EnginePreset` si hiciera falta.
- Compilar y probar en iOS, Windows y macOS; empaquetar Stockfish en los instaladores de escritorio.
- Firmar el APK con tu clave y crear la etiqueta `v1.0.0` al publicar (GPL).
- Configurar Supabase si quieres cuentas (README → «Sincronización opcional»).
- Lector de pantalla: el tablero se describe entero (piezas por casilla) y la tabla de jugadas es navegable; mover piezas solo con lector de pantalla aún no está implementado.
- Mejoras posibles: explorador de aperturas de Lichess cuando haya conexión, sonidos y fuente propios, sincronizar ajustes, rango de fechas al importar.

## Cómo probar cada fase

**Fase 1.** `flutter run -d linux` (o Android) → Analizar → Pegar PGN → elegir tu color → Importar → «Analizar partida». Comprobar: barra de progreso y botón Cancelar; la UI sigue respondiendo; clases con símbolo y color; tarjeta con explicación, mejor jugada y alternativas; flechas; gráfico (tocar salta a la jugada); tabla con filtros; pestaña Resumen; botón Exportar.

**Fase 2.** Problemas → Empezar (funciona en modo avión con el lote base); pista, solución, rating y racha. Problemas → icono de descarga → bajar un paquete y borrarlo. Tras analizar una partida con tu color indicado → «Mis errores».

**Fase 3.** Visión → elegir color/modo → Empezar. Analizar → «Importar de Lichess / Chess.com» con un usuario público. Analizar → «Jugar contra el motor» → al terminar, «Analizar partida». Progreso: gráficos y estadísticas.

**Fase 4.** Ajustes: idioma, tema, tablero, piezas, modo daltónico, profundidad, objetivo diario, exportar y borrar datos, Acerca de → Licencias. Primera ejecución: borra los datos de la app para ver la bienvenida.
