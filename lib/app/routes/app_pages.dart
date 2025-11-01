import 'package:get/get.dart';

import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/signup_role/signup_role_binding.dart';
import '../modules/signup_role/signup_role_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signupRole,
      page: () => const SignupRoleView(),
      binding: SignupRoleBinding(),
    ),
  ];
}
