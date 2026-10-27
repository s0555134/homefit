import 'package:flutter/material.dart';

abstract final class AppColors {
  static const canvas = Color(0xFFF6F7F3);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFEAF0EB);
  static const ink = Color(0xFF10221A);
  static const inkMuted = Color(0xFF526158);
  static const forest = Color(0xFF176246);
  static const forestDark = Color(0xFF103D2C);
  static const energy = Color(0xFFD5F66D);
  static const line = Color(0xFFDDE5DE);
  static const danger = Color(0xFFB42318);
}

abstract final class AppSpace {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const page = 20.0;
}

abstract final class AppRadius {
  static const control = BorderRadius.all(Radius.circular(12));
  static const card = BorderRadius.all(Radius.circular(16));
  static const hero = BorderRadius.all(Radius.circular(24));
}

ThemeData buildAppTheme() {
  const textTheme = TextTheme(
    displaySmall: TextStyle(
        fontSize: 34,
        height: 1.08,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: AppColors.ink),
    headlineMedium: TextStyle(
        fontSize: 26,
        height: 1.15,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.ink),
    titleLarge: TextStyle(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: AppColors.ink),
    titleMedium: TextStyle(
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w700,
        color: AppColors.ink),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: AppColors.ink),
    bodyMedium:
        TextStyle(fontSize: 14, height: 1.45, color: AppColors.inkMuted),
    labelLarge:
        TextStyle(fontSize: 14, height: 1.2, fontWeight: FontWeight.w700),
    labelMedium: TextStyle(
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.35),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: const ColorScheme.light(
      primary: AppColors.forest,
      onPrimary: Colors.white,
      secondary: AppColors.energy,
      onSecondary: AppColors.ink,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      outline: AppColors.line,
      error: AppColors.danger,
    ),
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0),
    cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.card)),
    dividerTheme: const DividerThemeData(color: AppColors.line, thickness: 1),
    filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.md, vertical: AppSpace.sm),
            textStyle: textTheme.labelLarge,
            shape:
                const RoundedRectangleBorder(borderRadius: AppRadius.control))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.md, vertical: AppSpace.sm),
            foregroundColor: AppColors.ink,
            side: const BorderSide(color: AppColors.line),
            textStyle: textTheme.labelLarge,
            shape:
                const RoundedRectangleBorder(borderRadius: AppRadius.control))),
    navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.surfaceMuted,
        height: 70,
        labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
  );
}
