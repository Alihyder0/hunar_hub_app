import 'package:get/get.dart';

import 'signup_role_controller.dart';

class SignupRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupRoleController>(() => SignupRoleController());
  }
}
