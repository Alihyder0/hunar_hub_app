import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/intro_anim_controller.dart';
import '../widgets/animated_back_button.dart';
import '../widgets/gradient_button.dart';
import '../widgets/logo_flip.dart';
import '../widgets/soft_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final IntroAnimController _controller;
  int _selectedMode = 0; // 0 = email, 1 = phone

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(IntroAnimController(), tag: 'login');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.playIn(showBack: true);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    if (Get.isRegistered<IntroAnimController>(tag: 'login')) {
      Get.delete<IntroAnimController>(tag: 'login');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SoftBackground(
          paintBottomLeft: false,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 0,
                  child: AnimatedBackButton(
                    controller: _controller,
                    onTap: () => Get.back(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        LogoFlip(controller: _controller, size: 104),
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _controller.headingFade,
                          child: SlideTransition(
                            position: _controller.headingSlide,
                            child: Column(
                              children: [
                                Text(
                                  'Welcome Back!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2E6D63),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Login to continue your journey',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    color: const Color(0xFF6D8781),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        FadeTransition(
                          opacity: _controller.contentFade,
                          child: SlideTransition(
                            position: _controller.contentSlide,
                            child: _buildLoginCard(context),
                          ),
                        ),
                        const SizedBox(height: 22),
                        FadeTransition(
                          opacity: _controller.ctaFade,
                          child: SlideTransition(
                            position: _controller.ctaSlide,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Don't have an account? Sign Up",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF2E6D63),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _controller.statsFade,
                          child: SlideTransition(
                            position: _controller.statsSlide,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                'Continuing to grow your training & skills.',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF7A928C),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 26, offset: Offset(0, 22)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToggle(),
          const SizedBox(height: 20),
          TextField(
            controller: _emailController,
            keyboardType: _selectedMode == 0 ? TextInputType.emailAddress : TextInputType.phone,
            decoration: _inputDecoration(
              hint: _selectedMode == 0 ? 'Email Address' : 'Phone Number',
              icon: _selectedMode == 0 ? Icons.mail_outline_rounded : Icons.phone_rounded,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: _inputDecoration(
              hint: 'Enter Password',
              icon: Icons.lock_outline_rounded,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF2E6D63)),
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 6),
          GradientButton(
            label: 'Login',
            onTap: () {},
            expand: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    final options = ['Email', 'Phone'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final selected = _selectedMode == index;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                if (_selectedMode != index) {
                  setState(() => _selectedMode = index);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: selected
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF2CB9A8), Color(0xFFE47D5C)],
                        )
                      : null,
                  color: selected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: selected
                      ? const [BoxShadow(color: Color(0x1F000000), blurRadius: 12, offset: Offset(0, 8))]
                      : null,
                ),
                child: Center(
                  child: Text(
                    options[index],
                    style: GoogleFonts.poppins(
                      color: selected ? Colors.white : const Color(0xFF748985),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: const Color(0xFF9AA7A3), fontSize: 13),
      prefixIcon: Icon(icon, color: const Color(0xFF2E6D63)),
      filled: true,
      fillColor: const Color(0xFFF5F6F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }
}
