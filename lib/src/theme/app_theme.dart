import 'package:flutter/material.dart';

class AppTheme {
  // Ethiopian Flag Inspired Colors
  static const Color primaryGreen = Color(0xFF009A44); 
  static const Color secondaryYellow = Color(0xFFFEDD00);
  static const Color accentRed = Color(0xFFFF0000);
  static const Color neutralCharcoal = Color(0xFF2C2C2C);
  static const Color softGray = Color(0xFFF5F5F5);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: softGray,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryGreen,
        secondary: secondaryYellow,
        error: accentRed,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: neutralCharcoal,
        elevation: 0,
        iconTheme: IconThemeData(color: neutralCharcoal),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
      ),
    );
  }
}