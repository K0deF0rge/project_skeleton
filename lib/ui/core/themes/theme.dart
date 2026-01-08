import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: AppColors.lightMode,
        scaffoldBackgroundColor: AppColors.lightMode.surfaceContainerLowest,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.lightMode.surfaceContainerLowest,
          foregroundColor: AppColors.lightMode.onSurface,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.lightMode.onSurface,
          ),
        ),
        // textTheme: const TextTheme(
        //   headlineLarge: TextStyle(
        //     fontSize: 32,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: -0.5,
        //   ),
        //   headlineMedium: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: -0.25,
        //   ),
        //   bodyLarge: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w500,
        //   ),
        //   bodyMedium: TextStyle(
        //     fontSize: 14,
        //   ),
        //   labelLarge: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightMode.primary,
            foregroundColor: AppColors.lightMode.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightMode.surfaceContainerLow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.lightMode.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.lightMode.primary, width: 2),
          ),
          labelStyle: TextStyle(color: AppColors.lightMode.onSurface),
          hintStyle: TextStyle(color: AppColors.lightMode.outline),
        ),
        cardTheme: CardThemeData(
          color: AppColors.lightMode.surface,
          elevation: 0,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.lightMode.primary,
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: AppColors.darkMode,
        scaffoldBackgroundColor: AppColors.darkMode.surfaceContainerLowest,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkMode.surfaceContainerLowest,
          foregroundColor: AppColors.darkMode.onSurface,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: AppColors.darkMode.onSurface,
          ),
        ),
        // textTheme: const TextTheme(
        //   headlineLarge: TextStyle(
        //     fontSize: 32,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: -0.5,
        //   ),
        //   headlineMedium: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: -0.25,
        //   ),
        //   bodyLarge: TextStyle(
        //     fontSize: 16,
        //     fontWeight: FontWeight.w500,
        //   ),
        //   bodyMedium: TextStyle(
        //     fontSize: 14,
        //   ),
        //   labelLarge: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkMode.primary,
            foregroundColor: AppColors.darkMode.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkMode.surfaceContainerLow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkMode.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkMode.primary, width: 2),
          ),
          labelStyle: TextStyle(color: AppColors.darkMode.onSurface),
          hintStyle: TextStyle(color: AppColors.darkMode.outline),
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkMode.surface,
          elevation: 0,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.darkMode.primary,
          ),
        ),
      );
}
