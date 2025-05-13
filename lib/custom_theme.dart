import 'package:flutter/material.dart';

import 'constants/colors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    ),
    iconTheme: const IconThemeData(),
    listTileTheme: const ListTileThemeData(),
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
    cardTheme: CardTheme(),
  );
}
