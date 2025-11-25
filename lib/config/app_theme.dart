import 'package:flutter/material.dart';
import 'package:mobile_sekolah_apps/config/app_typography.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,

    scaffoldBackgroundColor: AppColors.background,

    // APPBAR
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      foregroundColor: AppColors.white,
      titleTextStyle: AppTypography.h2.copyWith(color: AppColors.white),
      centerTitle: false,
    ),

    // TEXT THEME
    textTheme: const TextTheme(
      displayLarge: AppTypography.h1,
      displayMedium: AppTypography.h2,
      displaySmall: AppTypography.h3,
      bodyLarge: AppTypography.body1,
      bodyMedium: AppTypography.body2,
      bodySmall: AppTypography.caption,
    ),

    // BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // TEXTFIELD
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: AppTypography.caption,
    ),

    // CARD
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),

    // BOTTOM NAV
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textLight,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    ),
  );
}
