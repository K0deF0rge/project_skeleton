import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4B7BF5);
  static const Color secondary = Color(0xFF6EE7B7);
  static const Color tertiary = Color(0xFFFB923C);
  static const Color error = Color(0xFFFF6B6B);

  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral10 = Color(0xFFF7F8FA);
  static const Color neutral20 = Color(0xFFE3E7EC);
  static const Color neutral40 = Color(0xFFB8BDC7);
  static const Color neutral60 = Color(0xFF6B7280);
  static const Color neutral80 = Color(0xFF374151);
  static const Color neutral100 = Color(0xFF111827);

  static ColorScheme get lightMode => const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.black,
        tertiary: tertiary,
        onTertiary: Colors.white,
        error: error,
        onError: Colors.white,
        surface: neutral0,
        onSurface: neutral100,
        surfaceContainerHighest: neutral10,
        surfaceContainerHigh: neutral20,
        surfaceContainer: neutral20,
        surfaceContainerLow: neutral10,
        surfaceContainerLowest: neutral0,
        inverseSurface: neutral100,
        onInverseSurface: neutral10,
        outline: neutral40,
        outlineVariant: neutral20,
        shadow: Colors.black12,
        scrim: Colors.black54,
      );

  static ColorScheme get darkMode => const ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.black,
        tertiary: tertiary,
        onTertiary: Colors.black,
        error: error,
        onError: Colors.white,
        surface: neutral80,
        onSurface: neutral10,
        surfaceContainerHighest: neutral100,
        surfaceContainerHigh: neutral80,
        surfaceContainer: neutral80,
        surfaceContainerLow: neutral60,
        surfaceContainerLowest: neutral60,
        inverseSurface: neutral10,
        onInverseSurface: neutral100,
        outline: neutral40,
        outlineVariant: neutral60,
        shadow: Colors.black26,
        scrim: Colors.black87,
      );
}
