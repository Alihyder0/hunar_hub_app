import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class ProfileCompletionController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController iconController;
  late final Animation<double> iconScale;
  late final Animation<double> iconFade;
  late final AnimationController contentController;

  late final TextEditingController professionalTitleController;
  late final TextEditingController summaryController;
  late final TextEditingController skillInputController;
  late final TextEditingController certificationInputController;

  final RxList<String> selectedSkills = <String>[].obs;
  final RxList<String> customSkills = <String>[].obs;
  final RxList<String> certifications = <String>[].obs;

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

    professionalTitleController = TextEditingController();
    summaryController = TextEditingController();
    skillInputController = TextEditingController();
    certificationInputController = TextEditingController();

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
    if (!availableSkills.contains(skill) && !customSkills.contains(skill)) {
      customSkills.add(skill);
    }
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  void addSkillFromInput() {
    final skill = skillInputController.text.trim();
    if (skill.isEmpty) return;

    skillInputController.clear();
    if (!selectedSkills.contains(skill)) {
      selectedSkills.add(skill);
    }
    if (!availableSkills.contains(skill) && !customSkills.contains(skill)) {
      customSkills.add(skill);
    }
  }

  void removeCustomSkill(String skill) {
    customSkills.remove(skill);
    selectedSkills.remove(skill);
  }

  void addCertification() {
    final certification = certificationInputController.text.trim();
    if (certification.isEmpty) return;

    certificationInputController.clear();
    if (!certifications.contains(certification)) {
      certifications.add(certification);
    }
  }

  void removeCertification(String certification) {
    certifications.remove(certification);
  }

  void completeProfile() {
    Get.offAllNamed(AppRoutes.trainerDashboard);
  }

  void skipForNow() {
    Get.offAllNamed(AppRoutes.trainerDashboard);
  }

  @override
  void onClose() {
    iconController.dispose();
    contentController.dispose();
    professionalTitleController.dispose();
    summaryController.dispose();
    skillInputController.dispose();
    certificationInputController.dispose();
    super.onClose();
  }
}
