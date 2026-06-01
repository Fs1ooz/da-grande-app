import 'dart:math' as math;
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import '../theme.dart';

class DonutChart extends StatelessWidget {
  final List<String> labels;
  final List<int> values;
  final int maxValue;
  final List<Color> colors;

  const DonutChart({
    super.key,
    required this.labels,
    required this.values,
    required this.maxValue,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _DonutPainter(
          labels: labels,
          values: values,
          maxValue: maxValue,
          colors: colors,
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<String> labels;
  final List<int> values;
  final int maxValue;
  final List<Color> colors;

  _DonutPainter({
    required this.labels,
    required this.values,
    required this.maxValue,
    required this.colors,
  });

  static const double _labelMargin = 48;
  static const double _holeRatio = 0.42;
  static const double _gapRad = 0.04;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2 - _labelMargin;
    if (outerRadius <= 0) return;
    final innerRadius = outerRadius * _holeRatio;
    final midRadius = (outerRadius + innerRadius) / 2;
    final strokeWidth = outerRadius - innerRadius;
    final n = labels.length;
    if (n == 0) return;

    final total = values.fold<int>(0, (s, v) => s + v);
    final allZero = total == 0;

    final totalGap = n * _gapRad;
    final availableAngle = 2 * math.pi - totalGap;

    double startAngle = -math.pi / 2;

    for (int i = 0; i < n; i++) {
      final color = i < colors.length ? colors[i] : AppColors.primary;
      final double sweep;
      if (allZero) {
        sweep = availableAngle / n;
      } else {
        sweep = (values[i] / total) * availableAngle;
      }

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt
        ..color = allZero ? Colors.grey.shade300 : color;

      if (!allZero && sweep > 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: midRadius),
          startAngle,
          sweep,
          false,
          paint,
        );
      } else if (allZero) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: midRadius),
          startAngle,
          sweep,
          false,
          paint,
        );
      }

      // Label
      final midAngle = startAngle + sweep / 2;
      final labelPos = center +
          Offset(
            math.cos(midAngle) * (outerRadius + 18),
            math.sin(midAngle) * (outerRadius + 18),
          );

      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: allZero ? Colors.grey.shade400 : AppColors.ink,
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 72);

      double dx = labelPos.dx;
      final cosA = math.cos(midAngle);
      if (cosA < -0.3) {
        dx -= tp.width;
      } else if (cosA.abs() <= 0.3) {
        dx -= tp.width / 2;
      }
      tp.paint(canvas, Offset(dx, labelPos.dy - tp.height / 2));

      startAngle += sweep + _gapRad;
    }

    // Centro: media o "–"
    final avg = allZero
        ? null
        : values.fold<int>(0, (s, v) => s + v) / values.length;

    final centerText = allZero ? '–' : avg!.toStringAsFixed(1);
    const centerSub = 'media';

    final tpNum = TextPainter(
      text: TextSpan(
        text: centerText,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final tpSub = TextPainter(
      text: const TextSpan(
        text: centerSub,
        style: TextStyle(
          color: AppColors.muted,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final totalH = tpNum.height + 2 + tpSub.height;
    final topY = center.dy - totalH / 2;

    tpNum.paint(canvas, Offset(center.dx - tpNum.width / 2, topY));
    tpSub.paint(
        canvas, Offset(center.dx - tpSub.width / 2, topY + tpNum.height + 2));
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) =>
      old.maxValue != maxValue ||
      !listEquals(old.values, values) ||
      !listEquals(old.labels, labels) ||
      !listEquals(old.colors, colors);
}
