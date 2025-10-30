import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class OnboardingController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController flipController;
  late final Animation<double> flipAnimation;
  late final AnimationController contentController;
  late final AnimationController buttonController;
  late final Animation<double> buttonScale;

  @override
  void onInit() {
    super.onInit();
    flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    flipAnimation = Tween<double>(
      begin: math.pi / 2,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: flipController,
        curve: Curves.easeOutBack,
      ),
    );

    contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      reverseDuration: const Duration(milliseconds: 220),
    );
    buttonScale = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(
        parent: buttonController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!isClosed) {
        flipController.forward();
        contentController.forward();
      }
    });
  }

  Future<void> onGetStartedTap() async {
    if (flipController.isAnimating || buttonController.isAnimating) {
      return;
    }
    await buttonController.forward();
    await buttonController.reverse();
    await flipController.reverse();
    await Get.toNamed(AppRoutes.login);
    if (!isClosed) {
      flipController.forward();
      contentController.forward(from: 0);
    }
  }

  @override
  void onClose() {
    flipController.dispose();
    contentController.dispose();
    buttonController.dispose();
    super.onClose();
  }
}
