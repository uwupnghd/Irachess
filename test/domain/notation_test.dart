import 'package:flutter_test/flutter_test.dart';
import 'package:irachess/core/chess/notation.dart';

void main() {
  test('notación en español', () {
    expect(localizeSan('Nxe5', 'es'), 'Cxe5');
    expect(localizeSan('Qxf7#', 'es'), 'Dxf7#');
    expect(localizeSan('e8=Q+', 'es'), 'e8=D+');
    expect(localizeSan('Nf3 Nc6 Bb5 a6 O-O Rb8 Kh1', 'es'), 'Cf3 Cc6 Ab5 a6 O-O Tb8 Rh1');
    expect(localizeSan('Nxe5', 'en'), 'Nxe5');
    expect(localizeSan('Rival', 'es'), 'Rival');
  });
}
