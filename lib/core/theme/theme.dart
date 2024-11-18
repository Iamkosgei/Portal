import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/core/theme/colors.dart';

final theme = ThemeData(
  snackBarTheme: const SnackBarThemeData(
    actionTextColor: Colors.white,
  ),
  textTheme: lightTextTheme,
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade200,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    isDense: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return primaryColor.withOpacity(.8);
        }
        return primaryColor;
      }),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      enableFeedback: true,
      minimumSize: MaterialStateProperty.all(
        const Size(
          double.infinity,
          48,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
    background: backgroundColor,
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: backgroundColor,
    foregroundColor: Colors.white,
    surfaceTintColor: backgroundColor,
    titleTextStyle: lightTextTheme.titleMedium,
    centerTitle: false,
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
);

final lightTextTheme = GoogleFonts.lexendDecaTextTheme().copyWith(
  bodyMedium: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  titleSmall: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    color: Colors.white,
  ),
  titleMedium: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
  titleLarge: const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
);
