import 'dart:math';
import 'package:flutter/material.dart';

class StarryNightStyle extends CustomPainter {
  final Color backgroundColor;
  final Color starColor;
  final int starCount;
  final double starSizeRange;

  StarryNightStyle({
    this.backgroundColor = Colors.white,
    this.starColor = Colors.grey,
    this.starCount = 400,
    this.starSizeRange = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint the background
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Paint the stars
    final starPaint = Paint()
      ..color = starColor
      ..style = PaintingStyle.fill;

    final random = Random();

    for (int i = 0; i < starCount; i++) {
      final starSize = random.nextInt(starSizeRange as int) + 1;
      final starX = random.nextDouble() * size.width;
      final starY = random.nextDouble() * size.height;

      canvas.drawCircle(Offset(starX, starY), starSize / 2, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
