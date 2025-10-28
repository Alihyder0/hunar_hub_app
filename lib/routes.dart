import 'package:get/get.dart';
import 'package:hunar_hub_app/screens/log_in_screen.dart';
import 'screens/welcome_screen.dart';

class Routes {
  static const welcome = '/';
  static const login = '/login';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomeScreen(),
      transition: Transition.noTransition, // we animate inside the screen
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
