import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Un settore della ruota della vita.
class WheelSection {
  final String label;
  final double value; // 0.0 – 10.0
  final Color color;

  const WheelSection({
    required this.label,
    required this.value,
    required this.color,
  });
}

/// Grafico "Ruota della Vita" stile manuale: spicchi pastello dal centro
/// fino al valore, griglia circolare a 10 anelli, etichette tangenziali.
class WheelChart extends StatelessWidget {
  final List<WheelSection> sections;
  final int maxValue;

  const WheelChart({
    super.key,
    required this.sections,
    this.maxValue = 10,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _WheelPainter(
          sections: sections,
          maxValue: maxValue,
          isDark: isDark,
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<WheelSection> sections;
  final int maxValue;
  final bool isDark;

  static const double _startAngle = -math.pi / 2; // ore 12

  _WheelPainter({
    required this.sections,
    required this.maxValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final n = sections.length;
    if (n == 0 || maxValue <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final totalR = math.min(size.width, size.height) / 2;

    // Spazio riservato alle etichette (adattivo alla dimensione)
    final labelSpace = (totalR * 0.40).clamp(48.0, 80.0);
    final outerR = totalR - labelSpace;
    if (outerR <= 0) return;

    final sweepAngle = 2 * math.pi / n;
    final inkColor = isDark ? Colors.white : Colors.black;

    // ── 1. Spicchi colorati ──
    for (int i = 0; i < n; i++) {
      final v = sections[i].value.clamp(0.0, maxValue.toDouble());
      if (v <= 0) continue;
      final wedgeR = outerR * v / maxValue;
      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: wedgeR),
          _startAngle + i * sweepAngle,
          sweepAngle,
          false,
        )
        ..close();
      canvas.drawPath(
        path,
        Paint()
          ..color = sections[i].color.withValues(alpha: 0.52)
          ..style = PaintingStyle.fill,
      );
    }

    // ── 2. Anelli concentrici ──
    for (int ring = 1; ring <= maxValue; ring++) {
      final r = outerR * ring / maxValue;
      final isOuter = ring == maxValue;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = isOuter ? 2.2 : 0.65
          ..color = inkColor.withValues(alpha: isOuter ? 0.80 : 0.22),
      );
    }

    // ── 3. Raggi separatori ──
    final spokePaint = Paint()
      ..color = inkColor.withValues(alpha: 0.75)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < n; i++) {
      final angle = _startAngle + i * sweepAngle;
      canvas.drawLine(
        center,
        center + Offset(math.cos(angle) * outerR, math.sin(angle) * outerR),
        spokePaint,
      );
    }

    // ── 4. Etichette tangenziali ──
    final fontSize = (outerR * 0.115).clamp(8.5, 12.0);
    final maxWidth = (outerR * 0.9).clamp(55.0, 110.0);

    for (int i = 0; i < n; i++) {
      _drawLabel(canvas, i, n, center, outerR, fontSize, maxWidth, inkColor);
    }
  }

  void _drawLabel(Canvas canvas, int i, int n, Offset center, double outerR,
      double fontSize, double maxWidth, Color inkColor) {
    final sweepAngle = 2 * math.pi / n;
    final midAngle = _startAngle + (i + 0.5) * sweepAngle;

    // Rotazione tangenziale
    double rot = midAngle + math.pi / 2;
    // Normalizza a (-π, π]
    while (rot > math.pi) {
      rot -= 2 * math.pi;
    }
    while (rot <= -math.pi) {
      rot += 2 * math.pi;
    }
    // Capovolgi se il testo sarebbe sottosopra
    if (rot.abs() > math.pi / 2) {
      rot += math.pi;
      while (rot > math.pi) {
        rot -= 2 * math.pi;
      }
      while (rot <= -math.pi) {
        rot += 2 * math.pi;
      }
    }

    final tp = TextPainter(
      text: TextSpan(
        text: sections[i].label,
        style: TextStyle(
          color: inkColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: maxWidth);

    // Centro etichetta: a ridosso del bordo esterno
    final labelR = outerR + 6 + tp.height / 2;
    final pos = center +
        Offset(math.cos(midAngle) * labelR, math.sin(midAngle) * labelR);

    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(rot);
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WheelPainter old) {
    if (old.isDark != isDark || old.maxValue != maxValue) return true;
    if (old.sections.length != sections.length) return true;
    for (int i = 0; i < sections.length; i++) {
      if (old.sections[i].value != sections[i].value ||
          old.sections[i].color != sections[i].color) {
        return true;
      }
    }
    return false;
  }
}
