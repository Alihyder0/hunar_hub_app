import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCompletionController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController iconController;
  late final Animation<double> iconScale;
  late final Animation<double> iconFade;
  late final AnimationController contentController;

  late final TextEditingController aboutController;
  final RxList<String> selectedSkills = <String>[].obs;

  late final String email;

  final List<String> availableSkills = const [
    'Design Thinking',
    'UI/UX',
    'Data Analysis',
    'Communication',
    'Problem Solving',
    'Leadership',
    'Marketing',
    'Coding Basics',
  ];

  @override
  void onInit() {
    super.onInit();

    email = (Get.arguments is Map && (Get.arguments as Map).containsKey('email'))
        ? (Get.arguments as Map)['email'] as String
        : 'student@email.com';

    aboutController = TextEditingController();

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

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  void completeProfile() {
    Get.snackbar(
      'Profile Completed',
      'Your learning experience is now personalized!',
    );
  }

  void skipForNow() {
    Get.snackbar(
      'Skipped',
      'You can complete your profile anytime from settings.',
    );
  }

  @override
  void onClose() {
    iconController.dispose();
    contentController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
