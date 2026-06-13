import 'package:flutter/material.dart';

class AppColors {
  /// ================= PRIMARY BRAND =================
  static const Color primary = Color(0xFF6FCF97);
  static const Color secondary = Color(0xFF56CCF2);
  static const Color accent = Color(0xFFB8A1FF);

  /// ================= BACKGROUND =================
  static const Color background = Color(0xFFF8FAFC);
  static const Color white = Colors.white;

  /// ================= TEXT =================
  static const Color black = Colors.black87;
  static const Color grey = Colors.grey;

  /// ================= STATUS COLORS =================
  static const Color success = Color(0xFF6FCF97);
  static const Color warning = Color(0xFFFFD166);
  static const Color error = Color(0xFFFF6B6B);

  /// ================= SOFT UI COLORS =================
  static const Color calmBlue = Color(0xFFA7D8FF);
  static const Color softPurple = Color(0xFFD6C6FF);
  static const Color lightGreen = Color(0xFFEAF8F0);
  static const Color softYellow = Color(0xFFFFF4D6);
  static const Color softRed = Color(0xFFFFE5E5);

  /// ================= GRADIENT =================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient calmGradient = LinearGradient(
    colors: [
      Color(0xFFA7D8FF),
      Color(0xFFD6C6FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}