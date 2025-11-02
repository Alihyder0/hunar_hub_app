import 'package:get/get.dart';

import 'student_signup_controller.dart';

class StudentSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentSignupController>(() => StudentSignupController());
  }
}
