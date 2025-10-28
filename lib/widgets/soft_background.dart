import 'package:flutter/material.dart';

class SoftBackground extends StatelessWidget {
  final Widget child;
  final bool paintTopRight;
  final bool paintBottomLeft;

  const SoftBackground({
    super.key,
    required this.child,
    this.paintTopRight = true,
    this.paintBottomLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF8F3EB), Color(0xFFF1E7DA)],
              ),
            ),
          ),
        ),
        if (paintTopRight)
          Positioned(
            top: -120,
            right: -60,
            child: _GlowCircle(
              size: 260,
              colors: const [Color(0x662AB1A6), Color(0x002AB1A6)],
            ),
          ),
        if (paintBottomLeft)
          Positioned(
            bottom: -140,
            left: -40,
            child: _GlowCircle(
              size: 300,
              colors: const [Color(0x66E07B58), Color(0x00E07B58)],
            ),
          ),
        child,
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final List<Color> colors;
  const _GlowCircle({required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: colors,
        ),
      ),
    );
  }
}
