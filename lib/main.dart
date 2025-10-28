import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes.dart';

void main() {
  runApp(const HunarHubApp());
}

class HunarHubApp extends StatelessWidget {
  const HunarHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hunar Hub',
      initialRoute: AppRoutes.onboarding,
      getPages: AppPages.pages,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F1E7),
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2AB1A6),
          background: const Color(0xFFF7F1E7),
        ),
        useMaterial3: true,
      ),
    );
  }
}
