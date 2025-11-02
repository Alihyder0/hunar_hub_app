import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundStart = Color(0xFFF4E8DC);
  static const Color backgroundEnd = Color(0xFFFDF7EE);
  static const Color background = backgroundEnd;
  static const Color textPrimary = Color(0xFF3F2E2C);
  static const Color textSecondary = Color(0xFF7A655F);
  static const Color accentWarm = Color(0xFFFF8F66);
  static const Color accentDeep = Color(0xFF0083B0);
  static const Color accentMint = Color(0xFF4FC08D);
  static const Color muted = Color(0xFFB39B92);

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundStart, backgroundEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient brandGradient = LinearGradient(
    colors: [accentWarm, accentDeep],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [accentWarm, accentMint],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
