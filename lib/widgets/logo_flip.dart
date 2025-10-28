import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/intro_anim_controller.dart';

class LogoFlip extends StatelessWidget {
  const LogoFlip({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<IntroAnimController>();
    return AnimatedBuilder(
      animation: c.logoCtrl,
      builder: (_, __) {
        // Flip on Y axis (card-like)
        final m = Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..rotateY(c.logoRadians);
        return Transform(
          transform: m,
          alignment: Alignment.center,
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: const Color(0xFF2BB9A8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF20B2AA), Color(0xFFE07B58)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(  
                Icons.school,
                size: 56,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
