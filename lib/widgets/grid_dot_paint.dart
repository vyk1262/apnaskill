import 'package:flutter/material.dart';

class GridDotsBackground extends StatelessWidget {
  final double dotSpacing;
  final double dotRadius;
  final Widget child;

  GridDotsBackground({
    this.dotSpacing = 10.0,
    this.dotRadius = 1.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter:
              GridDotsPainter(dotSpacing: dotSpacing, dotRadius: dotRadius),
          size: Size.infinite,
        ),
        child, // Your content goes here
      ],
    );
  }
}

class GridDotsPainter extends CustomPainter {
  final double dotSpacing;
  final double dotRadius;

  GridDotsPainter({required this.dotSpacing, required this.dotRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;

    for (double x = dotSpacing / 2; x < size.width; x += dotSpacing) {
      for (double y = dotSpacing / 2; y < size.height; y += dotSpacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint if spacing or radius don't change.
  }
}
