import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryColor),
    listTileTheme: const ListTileThemeData(),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.textPrimary),
      hintStyle: TextStyle(color: AppColors.textSecondary),
      iconColor: AppColors.textPrimary,
      prefixIconColor: AppColors.textPrimary,
      suffixIconColor: AppColors.textPrimary,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    cardTheme: const CardTheme(
      color: AppColors.white,
      elevation: 4,
      shadowColor: AppColors.shadowMedium,
    ),
  );
}
