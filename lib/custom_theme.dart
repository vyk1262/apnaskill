import 'package:flutter/material.dart';

import 'constants/colors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.tertiaryColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black87,
      ),
      displayMedium: TextStyle(
        color: Colors.black87,
      ),
      displaySmall: TextStyle(
        color: Colors.black87,
      ),
      headlineLarge: TextStyle(
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        color: Colors.black87,
      ),
      titleLarge: TextStyle(
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        color: Colors.black87,
      ),
      labelLarge: TextStyle(
        color: Colors.black87,
      ),
      labelMedium: TextStyle(
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        color: Colors.black87,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black87,
      textColor: Colors.black87,
      selectedColor: Colors.black87,
      tileColor: Colors.grey,
      selectedTileColor: Colors.lightBlueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black87),
      hintStyle: TextStyle(color: Colors.grey),
      iconColor: Colors.black87,
      prefixIconColor: Colors.black87,
      suffixIconColor: Colors.black87,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.green; // Color when selected
        }
        return Colors.black87; // Default color
      }),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.tertiaryColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        color: Colors.white,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
      selectedColor: Colors.white,
      tileColor: Colors.purple,
      selectedTileColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.grey),
      iconColor: Colors.white,
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    cardTheme: const CardTheme(
      color: Colors.black87,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.green; // Color when selected
        }
        return Colors.white; // Default color
      }),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  );
}
