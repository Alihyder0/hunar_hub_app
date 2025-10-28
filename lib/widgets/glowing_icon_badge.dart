import 'package:flutter/material.dart';

class GlowingIconBadge extends StatelessWidget {
  final IconData icon;
  final double size;
  final List<Color> colors;
  final double blur;

  const GlowingIconBadge({
    super.key,
    required this.icon,
    this.size = 76,
    this.colors = const [Color(0xFF2CB8A8), Color(0xFFE37C5A)],
    this.blur = 22,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.45),
              blurRadius: blur,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.42,
          ),
        ),
      ),
    );
  }
}
