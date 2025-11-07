import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/signup_field.dart';
import '../../widgets/staggered_fade_slide.dart';
import 'trainer_signup_controller.dart';

class TrainerSignupView extends GetView<TrainerSignupController> {
  const TrainerSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF8EFE4), Color(0xFFF4E2CF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: -50,
            child: _BlurredCircle(
              diameter: 230,
              color: AppColors.accent.withOpacity(0.18),
            ),
          ),
          Positioned(
            bottom: -85,
            right: -30,
            child: _BlurredCircle(
              diameter: 270,
              color: AppColors.accentDeep.withOpacity(0.16),
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
                        maxWidth: 580,
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
                          const SizedBox(height: 16),
                          ScaleTransition(
                            scale: controller.iconScale,
                            child: FadeTransition(
                              opacity: controller.iconFade,
                              child: const BrandTile(
                                size: 92,
                                child: Icon(
                                  Icons.workspace_premium_outlined,
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
                                  'Sign up as Trainer to mentor passionate learners',
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
                                vertical: 30,
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
                                        child: SignupField(
                                          label: 'First Name',
                                          hint: 'Enter your first name',
                                        ),
                                      ),
                                      SizedBox(width: 18),
                                      Expanded(
                                        child: SignupField(
                                          label: 'Last Name',
                                          hint: 'Enter your last name',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 18),
                                  SignupField(
                                    label: 'Email Address',
                                    hint: 'you@example.com',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 18),
                                  SignupField(
                                    label: 'Phone Number',
                                    hint: '+92 300 1234567',
                                    keyboardType: TextInputType.phone,
                                  ),
                                  SizedBox(height: 18),
                                  SignupField(
                                    label: 'Password',
                                    hint: 'Create a strong password',
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 18),
                                  SignupField(
                                    label: 'Confirm Password',
                                    hint: 'Re-enter your password',
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 18),
                                  SignupField(
                                    label: 'CNIC',
                                    hint: '12345-1234567-1',
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(height: 18),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SignupField(
                                          label: 'Date of Birth',
                                          hint: 'DD / MM / YYYY',
                                        ),
                                      ),
                                      SizedBox(width: 18),
                                      Expanded(
                                        child: SignupField(
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
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
                            child: Column(
                              children: [
                                Text(
                                  'By continuing, you agree to our Terms of Service and Privacy Policy.',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.muted,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Need assistance with trainer onboarding? Reach out to our support team.',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.textSecondary.withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
