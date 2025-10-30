import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class HunarHubApp extends StatelessWidget {
  const HunarHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hunar Hub',
      theme: AppTheme.light,
      initialRoute: AppRoutes.onboarding,
      getPages: AppPages.routes,
    );
  }
}
