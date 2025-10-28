import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      initialRoute: Routes.welcome,
      getPages: AppPages.pages,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F0E8), // soft beige like Figma
        useMaterial3: true,
      ),
    );
  }
}
