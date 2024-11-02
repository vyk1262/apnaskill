import 'dart:math';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final Color lineColor;
  final double gridSpacing;
  final double boxSize;

  GridPainter({
    this.lineColor = Colors.black,
    this.gridSpacing = 20,
    this.boxSize = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

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

    // Draw square boxes (optional)
    if (boxSize > 0) {
      for (int i = 0; i < numRows; i++) {
        for (int j = 0; j < numCols; j++) {
          final x = j * gridSpacing;
          final y = i * gridSpacing;
          canvas.drawRect(Rect.fromLTWH(x, y, boxSize, boxSize), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
