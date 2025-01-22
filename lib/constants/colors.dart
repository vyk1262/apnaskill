import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.blueAccent;
  static const Color secondaryColor = Colors.purpleAccent;
  static const Color tertiaryColor = Colors.greenAccent;
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [Colors.purpleAccent, Colors.blueAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
