import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F1E7),
        textTheme: GoogleFonts.poppinsTextTheme(),
        
        useMaterial3: true,
      ),
    );
  }
}
