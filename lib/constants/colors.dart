import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette
  static const Color primaryColor = Color(0xFF1D4ED8); // EdTech Blue
  static const Color secondaryColor = Color(0xFF9333EA); // Vibrant Purple
  static const Color accentColor = Color(0xFF14B8A6); // Teal Accent
  static const Color highlight = Color(0xFFF59E0B); // Warm Amber

  // Neutral Palette
  static const Color white = Color(0xFFFFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color backgroundLight = Color(0xFFF8FAFC); // Subtle off-white
  static const Color backgroundDark = Color(0xFF0F172A); // Deep navy
  static const Color surface = Color(0xFF0B1220); // Elevated card background
  static const Color footerBackground = Color(0xFF0D0D0D);

  // Semantic Neutrals
  static const Color textPrimary = Color(0xFF1E293B); // Slate Dark
  static const Color textSecondary = Color(0xFF64748B); // Slate Medium
  static const Color textTertiary = Color(0xFF475569); // Muted Slate
  static const Color textLight = Color(0xFF94A3B8); // Slate Light

  // Status Colors
  static const Color success = Color(0xFF22C55E); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Bright Blue

  // Legacy / helper colors (prefer using core palette above)
  static const Color brandBlue = primaryColor;
  static const Color brandGreen = accentColor;
  static const Color brandPurple = secondaryColor;
  static const Color brandNavy = backgroundDark;

  // Gradients
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient gradientPrimarySoft = LinearGradient(
    colors: [
      primaryColor,
      primaryColor.withOpacity(0.7),
      primaryColor.withOpacity(0.4),
      primaryColor.withOpacity(0.1),
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.decal,
  );

  static const LinearGradient gradientHero = LinearGradient(
    colors: [backgroundDark, primaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientAccent = LinearGradient(
    colors: [accentColor, primaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color overlay = Color(0x801E293B); // Semi-transparent overlay
  static const Color shimmerBase = Color(0xFFE2E8F0); // Shimmer effect base
  static const Color shimmerHighlight = Color(0xFFF1F5F9); // Shimmer highlight
  static const Color border = Color(0xFFE2E8F0); // Border color
  static const Color divider = Color(0xFFE2E8F0); // Divider color

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // Light shadow
  static const Color shadowMedium = Color(0x26000000); // Medium shadow
  static const Color shadowDark = Color(0x33000000); // Dark shadow
}
