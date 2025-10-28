import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/intro_anim_controller.dart';
import '../widgets/animated_back_button.dart';
import '../widgets/glowing_icon_badge.dart';
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
  bool _rememberMe = true;
  bool _obscurePassword = true;

  late final Animation<double> _headingFade;
  late final Animation<Offset> _headingSlide;
  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(IntroAnimController(), tag: 'login');
    _headingFade = _controller.intervalAnimation(0.28, 0.58);
    _headingSlide = _controller.slideAnimation(0.28, 0.58, offset: const Offset(0, 0.18));
    _cardFade = _controller.intervalAnimation(0.44, 0.9);
    _cardSlide = _controller.slideAnimation(0.44, 0.9, offset: const Offset(0, 0.28));
    _taglineFade = _controller.intervalAnimation(0.72, 1);
    _taglineSlide = _controller.slideAnimation(0.72, 1, offset: const Offset(0, 0.22));

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
                        const SizedBox(height: 22),
                        FadeTransition(
                          opacity: _controller.badgeFade,
                          child: ScaleTransition(
                            scale: _controller.badgeScale,
                            child: const GlowingIconBadge(icon: Icons.lock_outline_rounded),
                          ),
                        ),
                        const SizedBox(height: 26),
                        FadeTransition(
                          opacity: _headingFade,
                          child: SlideTransition(
                            position: _headingSlide,
                            child: Column(
                              children: [
                                Text(
                                  'Welcome back',
                                  style: GoogleFonts.poppins(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2E6D63),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Log in to continue your craft journey',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    color: const Color(0xFF6D8781),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        FadeTransition(
                          opacity: _cardFade,
                          child: SlideTransition(
                            position: _cardSlide,
                            child: _buildLoginCard(context),
                          ),
                        ),
                        const SizedBox(height: 24),
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
                          opacity: _taglineFade,
                          child: SlideTransition(
                            position: _taglineSlide,
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
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 28, offset: Offset(0, 22)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2CB9A8), Color(0xFFE47D5C)],
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Let’s sign you in',
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _inputDecoration(
              hint: 'Enter Password',
              icon: Icons.lock_outline_rounded,
              suffix: IconButton(
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: const Color(0xFF7A928C)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _rememberMe = !_rememberMe),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _rememberMe ? const Color(0xFF2CB9A8) : const Color(0xFFE7EAEA),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: _rememberMe
                        ? const [BoxShadow(color: Color(0x1A2CB9A8), blurRadius: 12, offset: Offset(0, 6))]
                        : null,
                  ),
                  child: _rememberMe
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Remember me',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF4D756F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF2E6D63)),
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GradientButton(
            label: 'Login',
            onTap: () {},
            expand: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _DividerLabel(color: Colors.grey.shade300)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'or continue with',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF93A5A0),
                  ),
                ),
              ),
              Expanded(child: _DividerLabel(color: Colors.grey.shade300)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SocialButton(icon: Icons.g_mobiledata_rounded),
              SizedBox(width: 14),
              _SocialButton(icon: Icons.apple),
              SizedBox(width: 14),
              _SocialButton(icon: Icons.facebook),
            ],
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

  InputDecoration _inputDecoration({required String hint, required IconData icon, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(color: const Color(0xFF9AA7A3), fontSize: 13),
      prefixIcon: Icon(icon, color: const Color(0xFF2E6D63)),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFF5F6F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF2CB9A8), width: 1.4),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  final Color color;
  const _DividerLabel({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  const _SocialButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0x15000000), blurRadius: 18, offset: Offset(0, 12)),
            ],
            color: Colors.white,
          ),
          child: Icon(icon, color: const Color(0xFF2E6D63), size: 28),
        ),
      ),
    );
  }
}
