import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All colors and text styles from the AutoSphere UI/UX Guidelines (Section 4).
/// Keeping them in ONE place means if the design changes, you only edit here
/// instead of hunting through every screen.
class AppColors {
  // Primary - Vibrant Orange - used for booking buttons, primary actions
  static const Color primary = Color(0xFFF97316);

  // Secondary - Deep Navy
  static const Color secondary = Color(0xFF0D1117);

  // Background & Cards
  static const Color background = Color(0xFFF8FAFC); // Soft blue-grey background
  static const Color card = Color(0xFFFFFFFF);

  // Status colors
  static const Color statusAvailable = Color(0xFF22C55E); // Green
  static const Color statusInfo = Color(0xFF3B82F6);      // Blue
  static const Color statusLimited = Color(0xFFEAB308);   // Yellow
  static const Color statusClosed = Color(0xFFEF4444);    // Red

  // Helper text colors
  static const Color textPrimary = Color(0xFF0D1117);
  static const Color textSecondary = Color(0xFF64748B);
  
  // Custom orange details
  static const Color orangeLight = Color(0xFFFFECE0);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.card,
    ),

    // Headings use Poppins, body uses Plus Jakarta Sans (Section 4 Typography)
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
          fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.5),
      headlineMedium: GoogleFonts.poppins(
          fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.3),
      headlineSmall: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      bodyLarge: GoogleFonts.plusJakartaSans(fontSize: 16, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.textSecondary),
      bodySmall: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
    ),

    // Global button style - orange, rounded (matches "modern cards, smooth" feel)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 16),
        elevation: 0,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFF1F3F5), width: 1.5),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.poppins(
          fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -0.5),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      hintStyle: GoogleFonts.plusJakartaSans(color: const Color(0xFF94A3B8), fontSize: 14),
    ),

    useMaterial3: true,
  );
}
