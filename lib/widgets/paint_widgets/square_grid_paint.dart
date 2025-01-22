import 'package:flutter/material.dart';

class SquarePaint extends CustomPainter {
  final Color lineColor;
  final double gridSpacing;
  final double gridLineWidth;

  SquarePaint({
    this.lineColor = Colors.grey,
    this.gridSpacing = 20,
    this.gridLineWidth = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = gridLineWidth;

    // Calculate the number of rows and columns based on size and spacing
    final numRows = (size.height / gridSpacing).floor();
    final numCols = (size.width / gridSpacing).floor();

    // Draw horizontal lines
    for (int i = 0; i <= numRows; i++) {
      final y = i * gridSpacing;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw vertical lines
    for (int i = 0; i <= numCols; i++) {
      final x = i * gridSpacing;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
