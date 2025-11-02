import 'package:get/get.dart';

import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/profile_completion/profile_completion_binding.dart';
import '../modules/profile_completion/profile_completion_view.dart';
import '../modules/signup_role/signup_role_binding.dart';
import '../modules/signup_role/signup_role_view.dart';
import '../modules/student_signup/student_signup_binding.dart';
import '../modules/student_signup/student_signup_view.dart';
import '../modules/student_verification/student_verification_binding.dart';
import '../modules/student_verification/student_verification_view.dart';
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
    GetPage(
      name: AppRoutes.studentSignup,
      page: () => const StudentSignupView(),
      binding: StudentSignupBinding(),
    ),
    GetPage(
      name: AppRoutes.studentVerification,
      page: () => const StudentVerificationView(),
      binding: StudentVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.profileCompletion,
      page: () => const ProfileCompletionView(),
      binding: ProfileCompletionBinding(),
    ),
  ];
}
