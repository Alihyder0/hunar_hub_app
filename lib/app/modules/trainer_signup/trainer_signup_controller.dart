import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class TrainerSignupController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController iconController;
  late final Animation<double> iconScale;
  late final Animation<double> iconFade;
  late final AnimationController contentController;

  @override
  void onInit() {
    super.onInit();
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    iconScale = CurvedAnimation(
      parent: iconController,
      curve: Curves.easeOutBack,
    );

    iconFade = CurvedAnimation(
      parent: iconController,
      curve: Curves.easeOut,
    );

    contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!isClosed) {
        contentController.forward();
      }
    });
  }

  @override
  void onClose() {
    iconController.dispose();
    contentController.dispose();
    super.onClose();
  }

  void continueToVerification() {
    if (!isClosed) {
      Get.toNamed(
        AppRoutes.emailVerification,
        arguments: {'email': 'trainer@email.com'},
      );
    }
  }
}
