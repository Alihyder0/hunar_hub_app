import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/intro_anim_controller.dart';

class AnimatedBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AnimatedBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<IntroAnimController>();
    return FadeTransition(
      opacity: c.backFade,
      child: SlideTransition(
        position: c.backSlide,
        child: GestureDetector(
          onTap: onTap ?? Get.back,
          behavior: HitTestBehavior.opaque,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.arrow_back, size: 22),
          ),
        ),
      ),
    );
  }
}
