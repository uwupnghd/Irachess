import 'dart:math';

import 'package:dartchess/dartchess.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/ui/theme.dart';
import '../../../l10n/gen/app_localizations.dart';

/// Evaluación legible desde el punto de vista de las blancas.
String evalText({int? cp, int? mate}) {
  if (mate != null) return mate == 0 ? '#' : (mate > 0 ? '#$mate' : '-#${mate.abs()}');
  if (cp == null) return '–';
  final p = cp / 100;
  return '${p >= 0 ? '+' : '−'}${p.abs().toStringAsFixed(1)}';
}

/// Barra vertical de evaluación (blancas abajo si el tablero está orientado a blancas).
class EvalBar extends StatelessWidget {
  const EvalBar({super.key, required this.whiteWin, required this.label, required this.orientation, this.width = 22});
  final double whiteWin;
  final String label;
  final Side orientation;
  final double width;

  @override
  Widget build(BuildContext context) {
    final whiteAtBottom = orientation == Side.white;
    final w = whiteWin.clamp(2, 98) / 100;
    return Semantics(
      label: label,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: width,
          child: LayoutBuilder(builder: (context, c) {
            final whiteH = c.maxHeight * w;
            final white = Container(height: whiteH, color: const Color(0xFFF4F4F4));
            final black = Expanded(child: Container(color: const Color(0xFF2B2B2B)));
            final text = FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: whiteWin >= 50 ? Colors.black87 : Colors.white),
              ),
            );
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Stack(key: ValueKey(whiteWin.round()), children: [
                Column(children: whiteAtBottom ? [black, white] : [white, Expanded(child: Container(color: const Color(0xFF2B2B2B)))]),
                Positioned(
                  left: 0,
                  right: 0,
                  top: (whiteAtBottom == (whiteWin >= 50)) ? null : 4,
                  bottom: (whiteAtBottom == (whiteWin >= 50)) ? 4 : null,
                  child: text,
                ),
              ]),
            );
          }),
        ),
      ),
    );
  }
}

/// Gráfico de ventaja (probabilidad de las blancas). Tocar un punto salta a esa jugada.
class EvalGraph extends StatelessWidget {
  const EvalGraph({super.key, required this.whiteWins, required this.index, required this.onSelect, this.critical = const []});
  final List<double> whiteWins;
  final int index;
  final ValueChanged<int> onSelect;
  final List<int> critical;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);
    final spots = [for (var i = 0; i < whiteWins.length; i++) FlSpot(i.toDouble(), whiteWins[i])];
    return Semantics(
      label: l.evalGraph,
      child: SizedBox(
        height: 96,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: 100,
            minX: 0,
            maxX: max(1, whiteWins.length - 1).toDouble(),
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            backgroundColor: const Color(0xFF2B2B2B),
            extraLinesData: ExtraLinesData(
              horizontalLines: [HorizontalLine(y: 50, color: Colors.grey, strokeWidth: 0.5)],
              verticalLines: [
                for (final c in critical)
                  VerticalLine(x: c + 1.0, color: brandAmber.withValues(alpha: 0.5), strokeWidth: 1, dashArray: [3, 3]),
                VerticalLine(x: index.toDouble(), color: scheme.primary, strokeWidth: 2),
              ],
            ),
            lineTouchData: LineTouchData(
              handleBuiltInTouches: false,
              touchCallback: (event, response) {
                final spot = response?.lineBarSpots?.firstOrNull;
                if (spot != null && (event is FlTapUpEvent || event is FlPanUpdateEvent || event is FlPanDownEvent)) {
                  onSelect(spot.x.round());
                }
              },
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: false,
                color: const Color(0xFFF4F4F4),
                barWidth: 1,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: true, color: const Color(0xFFF4F4F4)),
              ),
            ],
          ),
          duration: Duration.zero,
        ),
      ),
    );
  }
}
