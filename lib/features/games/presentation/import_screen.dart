import 'dart:convert';

import 'package:dartchess/dartchess.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/providers.dart';
import '../../../core/ui/widgets/common.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../domain/pgn_import.dart';

String importErrorText(AppLocalizations l, PgnImportException e) => switch (e.code) {
  'empty' => l.importErrorEmpty,
  'tooLarge' => l.importErrorTooLarge,
  'tooManyGames' => l.importErrorTooManyGames,
  'illegalMove' => l.importErrorIllegal(e.san ?? '?', (e.game ?? 0) + 1, (e.ply ?? 0) ~/ 2 + 1),
  'badFen' => l.importErrorBadFen,
  'tooLong' => l.importErrorTooLong,
  _ => l.importErrorNoMoves,
};

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  final _text = TextEditingController();
  Side? _side;
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _openFile() async {
    final file = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: const ['pgn', 'txt']);
    if (file == null) return;
    final bytes = await file.xFile.readAsBytes();
    if (bytes.length > PgnImporter.maxBytes) {
      setState(() => _error = AppLocalizations.of(context).importErrorTooLarge);
      return;
    }
    _text.text = utf8.decode(bytes, allowMalformed: true);
  }

  Future<void> _import() async {
    final l = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final games = await compute(PgnImporter.parse, _text.text);
      final repo = ref.read(gamesRepositoryProvider);
      final ids = <int>[];
      for (final g in games) {
        ids.add((await repo.insert(g, source: 'pgn', userSide: _side)).$1);
      }
      if (!mounted) return;
      if (ids.length == 1) {
        context.go('/analyze/game/${ids.single}');
      } else {
        showSnack(context, l.importedCount(ids.length));
        context.go('/analyze');
      }
    } on PgnImportException catch (e) {
      setState(() => _error = importErrorText(l, e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.importTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            TextField(
              controller: _text,
              minLines: 8,
              maxLines: 16,
              decoration: InputDecoration(
                hintText: l.importHint,
                border: const OutlineInputBorder(),
                errorText: _error,
                errorMaxLines: 3,
              ),
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _openFile,
                icon: const Icon(Icons.folder_open),
                label: Text(l.actionOpenFile),
              ),
            ),
            SectionTitle(l.importWhichSide),
            SegmentedButton<Side?>(
              segments: [
                ButtonSegment(value: Side.white, label: Text(l.sideWhite)),
                ButtonSegment(value: Side.black, label: Text(l.sideBlack)),
                ButtonSegment(value: null, label: Text(l.sideUnknown)),
              ],
              selected: {_side},
              onSelectionChanged: (s) => setState(() => _side = s.first),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _busy ? null : _import,
              icon: _busy
                  ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.check),
              label: Text(l.importButton),
            ),
          ]),
        ),
      ),
    );
  }
}
