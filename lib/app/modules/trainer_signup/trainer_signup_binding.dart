import 'package:get/get.dart';

import 'trainer_signup_controller.dart';

class TrainerSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainerSignupController>(
      () => TrainerSignupController(),
    );
  }
}
