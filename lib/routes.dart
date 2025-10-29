import 'package:get/get.dart';

import 'screens/course_detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';

class AppRoutes {
  static const onboarding = '/';
  static const home = '/home';
  static const courseDetails = '/course-details';
}

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.courseDetails,
      page: () => const CourseDetailScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 350),
    ),
  ];
}
