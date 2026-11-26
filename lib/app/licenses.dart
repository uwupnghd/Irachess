import 'package:flutter/foundation.dart';

/// Avisos de licencia de componentes que no son paquetes Dart (se muestran
/// en Ajustes → Acerca de → Licencias, junto a las de los paquetes).
void registerThirdPartyLicenses() {
  LicenseRegistry.addLicense(() => Stream.fromIterable([
    const LicenseEntryWithLineBreaks(['IraChess'], '''
IraChess — Copyright (C) 2026 los autores de IraChess.

Este programa es software libre: puedes redistribuirlo y/o modificarlo bajo los
términos de la Licencia Pública General de GNU publicada por la Free Software
Foundation, versión 3. Se distribuye SIN NINGUNA GARANTÍA. Consulta el archivo
LICENSE del código fuente o https://www.gnu.org/licenses/gpl-3.0.html.'''),
    const LicenseEntryWithLineBreaks(['Stockfish'], '''
Stockfish 19 — Copyright (C) The Stockfish developers (see AUTHORS file).
GNU General Public License v3. https://stockfishchess.org
Código fuente: https://github.com/official-stockfish/Stockfish
En web se usa stockfish.js (lite, mono-hilo) de Nathan Rugg, también GPL-3.0:
https://github.com/nmrugg/stockfish.js'''),
    const LicenseEntryWithLineBreaks(['Lichess chess-openings'], '''
Nombres de aperturas ECO: https://github.com/lichess-org/chess-openings
Dominio público / CC0 1.0 Universal.'''),
    const LicenseEntryWithLineBreaks(['Lichess puzzle database'], '''
Problemas de ajedrez: https://database.lichess.org/#puzzles
CC0 1.0 Universal.'''),
    const LicenseEntryWithLineBreaks(['Piezas'], '''
cburnett (Colin M.L. Burnett) y merida (Armando Hernández Marroquín): GPLv2 o posterior.
chessnut (Alexis Luengas): Apache-2.0. fantasy, spatial y celtic (Maurizio Monge): MIT.
rhosgfx (RhosGFX): CC0 1.0. Distribuidas en el paquete chessground (GPL-3.0).'''),
  ]));
}
