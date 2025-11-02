import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/staggered_fade_slide.dart';
import 'student_signup_controller.dart';

class StudentSignupView extends GetView<StudentSignupController> {
  const StudentSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF7F1E7), Color(0xFFF2E6D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -70,
            left: -50,
            child: _BlurredCircle(
              diameter: 220,
              color: AppColors.accent.withOpacity(0.18),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -30,
            child: _BlurredCircle(
              diameter: 260,
              color: AppColors.accentDeep.withOpacity(0.15),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final minHeight = math.max(constraints.maxHeight - 64, 0.0);
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 32,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: minHeight,
                        maxWidth: 560,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0,
                            end: 0.15,
                            offset: const Offset(0, 0.02),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: Get.back,
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.textSecondary,
                                  textStyle: textTheme.bodyMedium,
                                ),
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 16,
                                ),
                                label: const Text('Back'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ScaleTransition(
                            scale: controller.iconScale,
                            child: FadeTransition(
                              opacity: controller.iconFade,
                              child: const BrandTile(
                                size: 90,
                                child: Icon(
                                  Icons.auto_awesome_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.08,
                            end: 0.25,
                            child: Column(
                              children: [
                                Text(
                                  'Create Account',
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Sign up as Student to start learning',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.15,
                            end: 0.6,
                            offset: const Offset(0, 0.04),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 28,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 28,
                                    offset: const Offset(0, 18),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _SignupField(
                                          label: 'First Name',
                                          hint: 'Enter your first name',
                                        ),
                                      ),
                                      SizedBox(width: 18),
                                      Expanded(
                                        child: _SignupField(
                                          label: 'Last Name',
                                          hint: 'Enter your last name',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 18),
                                  _SignupField(
                                    label: 'Email Address',
                                    hint: 'you@example.com',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 18),
                                  _SignupField(
                                    label: 'Phone Number',
                                    hint: '+92 300 1234567',
                                    keyboardType: TextInputType.phone,
                                  ),
                                  SizedBox(height: 18),
                                  _SignupField(
                                    label: 'Password',
                                    hint: 'Create a strong password',
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 18),
                                  _SignupField(
                                    label: 'Confirm Password',
                                    hint: 'Re-enter your password',
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 18),
                                  _SignupField(
                                    label: 'CNIC',
                                    hint: '12345-1234567-1',
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(height: 18),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _SignupField(
                                          label: 'Date of Birth',
                                          hint: 'DD / MM / YYYY',
                                        ),
                                      ),
                                      SizedBox(width: 18),
                                      Expanded(
                                        child: _SignupField(
                                          label: 'City',
                                          hint: 'Enter your city',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.55,
                            end: 0.85,
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: controller.continueToVerification,
                                style: FilledButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                                child: const Text('Continue to Verification'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.65,
                            end: 1,
                            child: Text(
                              'By continuing, you agree to our Terms of Service and Privacy Policy.',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.muted,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SignupField extends StatelessWidget {
  const _SignupField({
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF9F6F1),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: AppColors.muted.withOpacity(0.35),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: AppColors.muted.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  const _BlurredCircle({
    required this.diameter,
    required this.color,
  });

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
