import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hunar_hub_app/controllers/intro_anim_controller.dart';
import '../widgets/logo_flip.dart';
import '../widgets/animated_back_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(IntroAnimController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.playIn(showBack: true); // <- show the back anim here
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Back button (animated)
            Positioned(
              top: 4,
              left: 0,
              child: AnimatedBackButton(onTap: () => Get.back()),
            ),

            // Content
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const LogoFlip(),
                    const SizedBox(height: 14),
                    Text('Welcome Back!',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2E6D63),
                        )),
                    const SizedBox(height: 8),
                    Text('Login to continue your journey',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF5E7B77),
                        )),
                    const SizedBox(height: 18),

                    // Card form (fade/slide up)
                    AnimatedBuilder(
                      animation: c.contentCtrl,
                      builder: (_, __) {
                        return Opacity(
                          opacity: c.contentFade.value,
                          child: SlideTransition(
                            position: c.contentSlide,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 14,
                                    offset: Offset(0, 8),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Email / Phone toggle could be added later; for now TextFields
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Enter your email',
                                      prefixIcon: const Icon(Icons.email_outlined),
                                      filled: true,
                                      fillColor: const Color(0xFFF5F6F7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      filled: true,
                                      fillColor: const Color(0xFFF5F6F7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text('Forgot Password?'),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        foregroundColor: Colors.white,
                                        backgroundColor: const Color(0xFF2E6D63),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Login'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 14),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Don't have an account? Sign Up"),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
