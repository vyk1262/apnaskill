import 'dart:math';
import 'package:flutter/material.dart';

class StaticBubbles extends CustomPainter {
  final Color bubbleColor;
  final int bubbleCount;
  final double bubbleSizeRange;

  StaticBubbles({
    this.bubbleColor = const Color.fromARGB(255, 221, 247, 223),
    this.bubbleCount = 200,
    this.bubbleSizeRange = 50,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bubbleColor
      ..style = PaintingStyle.fill;

    final random = Random();

    for (int i = 0; i < bubbleCount; i++) {
      final bubbleSize = random.nextInt(bubbleSizeRange as int) + 10;
      final bubbleX = random.nextDouble() * size.width;
      final bubbleY = random.nextDouble() * size.height;

      canvas.drawCircle(Offset(bubbleX, bubbleY), bubbleSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
