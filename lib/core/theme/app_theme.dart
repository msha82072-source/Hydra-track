import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme => _createTheme(
        brightness: Brightness.light,
        background: AppColors.background,
        cardBackground: AppColors.cardBackground,
        textThemeColor: AppColors.textDark,
        secondaryText: AppColors.textGrey,
      );

  static ThemeData get darkTheme => _createTheme(
        brightness: Brightness.dark,
        background: AppColors.backgroundDark,
        cardBackground: AppColors.cardBackgroundDark,
        textThemeColor: AppColors.textWhite,
        secondaryText: AppColors.textGreyDark,
      );

  static ThemeData get blackTheme => _createTheme(
        brightness: Brightness.dark,
        background: AppColors.backgroundBlack,
        cardBackground: AppColors.cardBackgroundBlack,
        textThemeColor: AppColors.textWhite,
        secondaryText: AppColors.textGreyDark,
      );

  static ThemeData _createTheme({
    required Brightness brightness,
    required Color background,
    required Color cardBackground,
    required Color textThemeColor,
    required Color secondaryText,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      brightness: brightness,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: background,
      cardColor: cardBackground,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.dropMedium,
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: cardBackground,
        onSurface: textThemeColor,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w600),
        headlineMedium: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w600),
        headlineSmall: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w500),
        titleSmall: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w500),
        bodyLarge: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.normal),
        bodyMedium: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.normal),
        bodySmall: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.normal),
        labelLarge: GoogleFonts.outfit(color: textThemeColor, fontWeight: FontWeight.w500),
        labelMedium: GoogleFonts.outfit(color: secondaryText, fontWeight: FontWeight.w500),
        labelSmall: GoogleFonts.outfit(color: secondaryText, fontWeight: FontWeight.w500),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textThemeColor),
        titleTextStyle: GoogleFonts.outfit(
          color: textThemeColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: EdgeInsets.zero,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return isDark ? AppColors.progressBarBackgroundDark : AppColors.toggleInactive;
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: secondaryText,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
