import 'package:flutter/material.dart';

class AppColors {
  /// ================= PRIMARY (PURPLE THEME) =================
  static const Color primary = Color(0xFF7C4DFF);
  static const Color primaryLight = Color(0xFFB388FF);
  static const Color secondary = Color(0xFFB388FF);

  /// ================= BACKGROUND =================
  static const Color background = Color(0xFF0B0B12);
  static const Color surface = Color(0xFF151526);
  static const Color card = Color(0xFF1C1C24);

  /// ================= TEXT =================
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white38;

  /// ================= STATUS COLORS =================
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFFF4D4F);

  /// ================= CHAT UI =================
  static const Color userBubble = Color(0xFF7C4DFF);
  static const Color botBubble = Color(0xFF1C1C24);

  /// ================= GRADIENT =================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF7C4DFF),
      Color(0xFFB388FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient softGlowGradient = LinearGradient(
    colors: [
      Color(0xFF7C4DFF),
      Color(0xFF3A2A6A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// ================= GLASS EFFECT =================
  static Color glass = Colors.white.withOpacity(0.06);
  static Color border = Colors.white.withOpacity(0.08);
}