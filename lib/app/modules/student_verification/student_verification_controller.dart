import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentVerificationController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController iconController;
  late final Animation<double> iconScale;
  late final Animation<double> iconFade;
  late final AnimationController contentController;

  late final List<TextEditingController> otpControllers;
  late final List<FocusNode> otpFocusNodes;
  late final String email;

  @override
  void onInit() {
    super.onInit();

    email = (Get.arguments is Map && (Get.arguments as Map).containsKey('email'))
        ? (Get.arguments as Map)['email'] as String
        : 'student@email.com';

    otpControllers =
        List<TextEditingController>.generate(6, (_) => TextEditingController());
    otpFocusNodes = List<FocusNode>.generate(6, (_) => FocusNode());

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
        if (otpFocusNodes.isNotEmpty) {
          otpFocusNodes.first.requestFocus();
        }
      }
    });
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  void onOtpSubmitted(int index) {
    if (index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    } else {
      verifyCode();
    }
  }

  void verifyCode() {
    final otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length < otpControllers.length || otp.contains(RegExp(r'\s'))) {
      Get.snackbar('Incomplete Code', 'Please enter the 6-digit code.');
      return;
    }

    Get.snackbar('Success', 'Your email has been verified!');
  }

  void resendCode() {
    Get.snackbar('Verification Code', 'A new verification code has been sent.');
  }

  @override
  void onClose() {
    iconController.dispose();
    contentController.dispose();
    for (final controller in otpControllers) {
      controller.dispose();
    }
    for (final node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
