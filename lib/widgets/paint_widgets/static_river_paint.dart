import 'dart:math';
import 'package:flutter/material.dart';

class StaticRiverStyle extends CustomPainter {
  final Color riverColor;
  final Color bankColor;

  StaticRiverStyle({
    this.riverColor = const Color.fromARGB(255, 29, 28, 29),
    this.bankColor = const Color.fromARGB(255, 197, 199, 235),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = riverColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x++) {
      final y =
          sin(x / size.width * 2 * pi) * size.height / 4 + size.height / 2;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw the river banks
    final bankPaint = Paint()
      ..color = bankColor
      ..style = PaintingStyle.fill;

    final bankPath = Path();
    bankPath.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x++) {
      final y =
          sin(x / size.width * 2 * pi) * size.height / 4 + size.height / 2;
      bankPath.lineTo(x, y + 10); // Adjust the bank width here
    }

    bankPath.lineTo(size.width, size.height);
    bankPath.lineTo(0, size.height);
    bankPath.close();

    canvas.drawPath(bankPath, bankPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
