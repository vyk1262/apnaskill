import 'package:flutter/material.dart';
import 'package:skill_factorial/constants/colors.dart';

Widget buildCtaButton({
  required String text,
  required VoidCallback onPressed,
  Color bgColor = AppColors.primaryColor,
  Color fgColor = AppColors.white,
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
