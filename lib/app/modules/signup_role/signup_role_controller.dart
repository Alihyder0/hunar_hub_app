import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SignupRoleController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController iconController;
  late final Animation<double> iconScale;
  late final Animation<double> iconFade;
  late final AnimationController contentController;

  final RxInt selectedRole = (-1).obs;

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
      duration: const Duration(milliseconds: 1500),
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

  void selectRole(int index) {
    selectedRole.value = index;
  }

  void continueWithRole() {
    final roleIndex = selectedRole.value;
    if (roleIndex == -1) {
      return;
    }
    final roleName = roleIndex == 0 ? 'Student' : 'Trainer';
    Get.snackbar('Role Selected', 'Continue as $roleName');
  }

  @override
  void onClose() {
    iconController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
