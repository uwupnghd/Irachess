/// Notación algebraica en el idioma del usuario (en español: R D T A C).
const _es = {'K': 'R', 'Q': 'D', 'R': 'T', 'B': 'A', 'N': 'C'};

final _pieceRe = RegExp(r'(^|=|\s)([KQRBN])(?=[a-h1-8x=@+#]|$)');

/// Traduce las letras de pieza en una jugada o línea SAN ("Nxe5", "Qxf7#",
/// "e8=Q", "Nf3 Nc6 Bb5"). No toca nombres propios ni otras palabras.
String localizeSan(String san, String languageCode) {
  if (languageCode != 'es') return san;
  return san.replaceAllMapped(_pieceRe, (m) => '${m[1]}${_es[m[2]]}');
}
