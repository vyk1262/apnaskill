import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF2563EB); // Modern Blue
  static const Color secondaryColor = Color(0xFF7C3AED); // Deep Purple
  static const Color accentColor = Color(0xFF10B981); // Emerald Green

  // Background Colors
  static const Color backgroundColor = Color(0xFFF8FAFC); // Light Gray Blue
  static const Color surfaceColor = Color(0xFFFFFFFF); // Pure White
  static const Color cardBackground = Color(0xFFFFFFFF); // Card White

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B); // Slate Dark
  static const Color textSecondary = Color(0xFF64748B); // Slate Medium
  static const Color textLight = Color(0xFF94A3B8); // Slate Light

  // Status Colors
  static const Color success = Color(0xFF059669); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFDC2626); // Red
  static const Color info = Color(0xFF3B82F6); // Blue

  // Gradients
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradientPrimaryMain = LinearGradient(
    colors: [
      Color.fromARGB(255, 2, 1, 110),
      Color.fromARGB(255, 15, 12, 189),
      Color.fromARGB(255, 69, 72, 238),
      Color.fromARGB(255, 255, 255, 255)
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.decal,
  );

  static const LinearGradient gradientSecondary = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientAccent = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Overlay Colors
  static const Color overlay = Color(0x801E293B); // Semi-transparent overlay
  static const Color shimmerBase = Color(0xFFE2E8F0); // Shimmer effect base
  static const Color shimmerHighlight =
      Color(0xFFF1F5F9); // Shimmer effect highlight

  // Border and Divider Colors
  static const Color border = Color(0xFFE2E8F0); // Border color
  static const Color divider = Color(0xFFE2E8F0); // Divider color

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // Light shadow
  static const Color shadowMedium = Color(0x26000000); // Medium shadow
  static const Color shadowDark = Color(0x33000000); // Dark shadow
}
