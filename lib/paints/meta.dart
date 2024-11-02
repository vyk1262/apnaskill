import 'dart:math';
import 'package:flutter/material.dart';

class MetaShapes extends CustomPainter {
  final Color triangleColor;
  final Color moonColor;
  final Color squareColor;

  MetaShapes({
    this.triangleColor = Colors.red,
    this.moonColor = Colors.yellow,
    this.squareColor = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the triangle
    final trianglePath = Path();
    trianglePath.moveTo(0, size.height);
    trianglePath.lineTo(size.width / 2, 0);
    trianglePath.lineTo(size.width, size.height);
    trianglePath.close();

    final trianglePaint = Paint()
      ..color = triangleColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(trianglePath, trianglePaint);

    // Draw the half-moon
    final moonPath = Path();
    moonPath.moveTo(size.width / 4, size.height / 2);
    moonPath.arcTo(
        Rect.fromCircle(
            center: Offset(size.width / 4, size.height / 2),
            radius: size.width / 4),
        pi / 2,
        -pi,
        false);
    moonPath.lineTo(size.width / 4, size.height / 2);

    final moonPaint = Paint()
      ..color = moonColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(moonPath, moonPaint);

    // Draw the tilted square
    final squarePath = Path();
    squarePath.moveTo(size.width * 3 / 4, 0);
    squarePath.lineTo(size.width, size.height / 4);
    squarePath.lineTo(size.width * 3 / 4, size.height * 3 / 4);
    squarePath.lineTo(size.width / 2, size.height);
    squarePath.close();

    final squarePaint = Paint()
      ..color = squareColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(squarePath, squarePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
