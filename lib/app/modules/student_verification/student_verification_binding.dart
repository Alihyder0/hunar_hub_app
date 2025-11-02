import 'package:get/get.dart';

import 'student_verification_controller.dart';

class StudentVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentVerificationController>(
      () => StudentVerificationController(),
    );
  }
}
