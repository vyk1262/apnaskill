import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 100, 100, 200);
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [Colors.purpleAccent, Colors.blueAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
