import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF7F1E7);
  static const Color textPrimary = Color(0xFF3F2E2C);
  static const Color textSecondary = Color(0xFF7A655F);
  static const Color accent = Color(0xFF4FC08D);
  static const Color accentDeep = Color(0xFF0083B0);
  static const Color muted = Color(0xFFB39B92);

  static const Gradient brandGradient = LinearGradient(
    colors: [accent, accentDeep],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
