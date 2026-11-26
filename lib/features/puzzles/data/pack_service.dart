import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/network/http.dart';
import 'puzzle_repository.dart';

/// URL base de los paquetes (index.json + CSV). Se puede cambiar al compilar
/// con --dart-define=PUZZLE_PACKS_URL=https://.../
const packsBaseUrl = String.fromEnvironment(
  'PUZZLE_PACKS_URL',
  defaultValue: 'https://raw.githubusercontent.com/uwupnghd/irachess/main/puzzle_packs/',
);

class PackService {
  PackService(this._dio, this._repo);
  final Dio _dio;
  final PuzzleRepository _repo;

  Future<List<PackInfo>> fetchIndex() async {
    final res = await withRetry(
        () => _dio.get<String>('${packsBaseUrl}index.json', options: Options(responseType: ResponseType.plain)));
    return [for (final j in jsonDecode(res.data!) as List<Object?>) PackInfo.fromJson(j! as Map<String, Object?>)];
  }

  Future<void> download(PackInfo info) async {
    final res = await withRetry(() => _dio.get<String>('$packsBaseUrl${info.file}', options: Options(responseType: ResponseType.plain)));
    await _repo.installPack(info, res.data!);
  }
}
