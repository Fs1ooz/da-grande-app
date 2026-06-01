import 'dart:math' as math;
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import '../theme.dart';

/// Disegna una "ruota" in stile radar: anelli concentrici, raggi etichettati
/// e un poligono che rappresenta i punteggi.
class RadarWheel extends StatelessWidget {
  final List<String> labels;
  final List<int> values;
  final int maxValue;
  final Color color;

  const RadarWheel({
    super.key,
    required this.labels,
    required this.values,
    required this.maxValue,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _RadarPainter(
          labels: labels,
          values: values,
          maxValue: maxValue,
          color: color,
          ringColor:
              isDark ? AppColors.darkBorder : const Color(0xFFE1E6F0),
          spokeColor:
              isDark ? AppColors.darkBorder : const Color(0xFFD7DEED),
          labelColor: isDark ? Colors.white70 : AppColors.ink,
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final List<String> labels;
  final List<int> values;
  final int maxValue;
  final Color color;
  final Color ringColor;
  final Color spokeColor;
  final Color labelColor;

  _RadarPainter({
    required this.labels,
    required this.values,
    required this.maxValue,
    required this.color,
    required this.ringColor,
    required this.spokeColor,
    required this.labelColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 46;
    final n = labels.length;
    if (n == 0 || radius <= 0) return;

    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const rings = 4;
    for (int r = 1; r <= rings; r++) {
      canvas.drawCircle(center, radius * r / rings, ringPaint);
    }

    final spokePaint = Paint()
      ..color = spokeColor
      ..strokeWidth = 1;
    for (int i = 0; i < n; i++) {
      final angle = _angle(i, n);
      final end = center +
          Offset(math.cos(angle) * radius, math.sin(angle) * radius);
      canvas.drawLine(center, end, spokePaint);
    }

    final path = Path();
    bool hasData = false;
    for (int i = 0; i < n; i++) {
      final v = i < values.length ? values[i] : 0;
      final ratio = maxValue == 0 ? 0.0 : (v.clamp(0, maxValue) / maxValue);
      if (v > 0) hasData = true;
      final angle = _angle(i, n);
      final p = center +
          Offset(math.cos(angle) * radius * ratio,
              math.sin(angle) * radius * ratio);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();

    if (hasData) {
      canvas.drawPath(
        path,
        Paint()
          ..color = color.withValues(alpha: 0.22)
          ..style = PaintingStyle.fill,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeJoin = StrokeJoin.round,
      );
      for (int i = 0; i < n; i++) {
        final v = i < values.length ? values[i] : 0;
        final ratio =
            maxValue == 0 ? 0.0 : (v.clamp(0, maxValue) / maxValue);
        final angle = _angle(i, n);
        final p = center +
            Offset(math.cos(angle) * radius * ratio,
                math.sin(angle) * radius * ratio);
        canvas.drawCircle(p, 3.5, Paint()..color = color);
      }
    }

    for (int i = 0; i < n; i++) {
      final angle = _angle(i, n);
      final labelPos = center +
          Offset(math.cos(angle) * (radius + 22),
              math.sin(angle) * (radius + 22));
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 90);
      double dx = labelPos.dx;
      final cos = math.cos(angle);
      if (cos < -0.3) {
        dx -= tp.width;
      } else if (cos.abs() <= 0.3) {
        dx -= tp.width / 2;
      }
      tp.paint(canvas, Offset(dx, labelPos.dy - tp.height / 2));
    }
  }

  double _angle(int i, int n) => -math.pi / 2 + 2 * math.pi * i / n;

  @override
  bool shouldRepaint(covariant _RadarPainter old) =>
      old.color != color ||
      old.maxValue != maxValue ||
      old.ringColor != ringColor ||
      old.spokeColor != spokeColor ||
      old.labelColor != labelColor ||
      !listEquals(old.values, values) ||
      !listEquals(old.labels, labels);
}
