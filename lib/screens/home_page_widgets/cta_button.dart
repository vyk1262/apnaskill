import 'package:flutter/material.dart';

Widget buildCtaButton({
  required String text,
  required VoidCallback onPressed,
  Color bgColor = const Color(0xFF4A90E2),
  Color fgColor = Colors.white,
  double ftSize = 20.0,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: ftSize,
      ),
    ),
  );
}
