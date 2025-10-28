import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/intro_anim_controller.dart';

class AnimatedBackButton extends StatelessWidget {
  final IntroAnimController controller;
  final VoidCallback? onTap;
  const AnimatedBackButton({super.key, required this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller.backFade,
      child: SlideTransition(
        position: controller.backSlide,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF2E6D63)),
                  const SizedBox(width: 6),
                  Text(
                    'Back',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF2E6D63),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
