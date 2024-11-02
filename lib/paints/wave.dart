import 'dart:math';
import 'package:flutter/material.dart';

class SineWaveBackground extends StatelessWidget {
  final Color color;
  final double amplitude;
  final double frequency;
  final double phase;

  const SineWaveBackground({
    Key? key,
    this.color = Colors.blue,
    this.amplitude = 50.0,
    this.frequency = 1.0,
    this.phase = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SineWavePainter(color, amplitude, frequency, phase, 50),
      size: Size(double.infinity, double.infinity),
    );
  }
}

class SineWavePainter extends CustomPainter {
  final Color color;
  final double amplitude;
  final double frequency;
  final double phase;
  final double strokeWidth;

  SineWavePainter(
      this.color, this.amplitude, this.frequency, this.phase, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x++) {
      final y = amplitude * sin(x / size.width * 2 * pi * frequency + phase) +
          size.height / 2;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
