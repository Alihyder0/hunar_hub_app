import 'package:flutter/material.dart';

import '../controllers/intro_anim_controller.dart';

class LogoFlip extends StatelessWidget {
  final IntroAnimController controller;
  final double size;
  const LogoFlip({super.key, required this.controller, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.logoCtrl,
      builder: (_, __) {
        // Flip on Y axis (card-like)
        final m = Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateY(controller.logoRadians);
        return Transform(
          transform: m,
          alignment: Alignment.center,
          child: Hero(
            tag: 'hunarhub-logo',
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2CB9A8), Color(0xFFE47D5C)],
                ),
                borderRadius: BorderRadius.circular(size * 0.26),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x2A000000),
                    blurRadius: 30,
                    offset: Offset(0, 16),
                  )
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: size * 0.32,
                      height: size * 0.32,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: [Color(0x33FFFFFF), Color(0x00FFFFFF)],
                        ),
                        borderRadius: BorderRadius.circular(size * 0.16),
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.track_changes_rounded,
                      size: size * 0.42,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
