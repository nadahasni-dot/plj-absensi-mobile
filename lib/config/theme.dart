import 'package:flutter/material.dart';
import 'package:plj_absensi_mobile/constants/colors.dart';

// * BORDER
final defaultBorder = BorderRadius.circular(10);
final smallBorder = BorderRadius.circular(6);

// * SHADOW
final defaultShadow = BoxShadow(
  blurRadius: 2,
  color: black.withOpacity(0.08),
);

// * THEME
final themeData = ThemeData(
  fontFamily: 'inter',
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: white,
  appBarTheme: const AppBarTheme(
    elevation: 0.5,
    centerTitle: true,
    backgroundColor: white,
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: black,
      fontWeight: FontWeight.w500,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 1,
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(width: 1, color: textDarkGreyColor),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    labelStyle: const TextStyle(color: textLightGrey),
    floatingLabelStyle: const TextStyle(color: textDarkColor),
    hintStyle: const TextStyle(
      fontSize: 14,
      color: textLightGrey,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(6),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: errorColor),
      borderRadius: BorderRadius.circular(6),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: textDarkGreyColor),
      borderRadius: BorderRadius.circular(6),
    ),
    errorStyle: const TextStyle(color: errorColor),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: black,
    unselectedLabelColor: textDarkGreyColor,
    labelStyle: TextStyle(
      color: black,
      fontFamily: 'inter',
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      color: textDarkGreyColor,
      fontFamily: 'inter',
      fontWeight: FontWeight.w500,
    ),
  ),
);
