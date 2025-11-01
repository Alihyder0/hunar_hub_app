import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/role_option_card.dart';
import '../../widgets/staggered_fade_slide.dart';
import 'signup_role_controller.dart';

class SignupRoleView extends GetView<SignupRoleController> {
  const SignupRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF7F1E7), Color(0xFFF1E8DD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: -60,
            child: _BlurredCircle(
              diameter: 220,
              color: AppColors.accent.withOpacity(0.2),
            ),
          ),
          Positioned(
            bottom: -90,
            right: -40,
            child: _BlurredCircle(
              diameter: 260,
              color: AppColors.accentDeep.withOpacity(0.18),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final minHeight = math.max(constraints.maxHeight - 64, 0.0);
                return Center(
                  child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: minHeight, maxWidth: 540),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0,
                          end: 0.15,
                          offset: const Offset(0, 0.02),
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              textStyle: textTheme.bodyMedium,
                            ),
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16,
                            ),
                            label: const Text('Back to Login'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ScaleTransition(
                          scale: controller.iconScale,
                          child: FadeTransition(
                            opacity: controller.iconFade,
                            child: const BrandTile(
                              size: 92,
                              child: Icon(
                                Icons.auto_awesome_outlined,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.1,
                          end: 0.25,
                          child: Column(
                            children: [
                              Text(
                                'Sign Up As',
                                style: textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Choose your role to get started',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Obx(
                          () {
                            final selected = controller.selectedRole.value;
                            return Column(
                              children: [
                                StaggeredFadeSlide(
                                  controller: controller.contentController,
                                  start: 0.18,
                                  end: 0.45,
                                  child: RoleOptionCard(
                                    title: 'Student',
                                    subtitle: 'Learn skills and master traditional crafts',
                                    benefits: const [
                                      'Structured lessons curated by experienced trainers.',
                                      'Hands-on projects to apply what you learn instantly.',
                                      'Join a vibrant community of fellow learners.',
                                    ],
                                    icon: Icons.school_rounded,
                                    isSelected: selected == 0,
                                    onTap: () => controller.selectRole(0),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                StaggeredFadeSlide(
                                  controller: controller.contentController,
                                  start: 0.3,
                                  end: 0.6,
                                  child: RoleOptionCard(
                                    title: 'Trainer',
                                    subtitle: 'Share your expertise and teach others',
                                    benefits: const [
                                      'Create immersive courses with step-by-step guidance.',
                                      'Earn income by mentoring passionate learners.',
                                      'Track learner progress with intuitive analytics.',
                                    ],
                                    icon: Icons.workspace_premium_rounded,
                                    isSelected: selected == 1,
                                    onTap: () => controller.selectRole(1),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.45,
                          end: 0.75,
                          child: SizedBox(
                            width: double.infinity,
                            child: Obx(
                              () {
                                final selected = controller.selectedRole.value;
                                return FilledButton(
                                  onPressed: selected == -1
                                      ? null
                                      : controller.continueWithRole,
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: AppColors.accent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: const Text('Continue to Sign Up'),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.6,
                          end: 0.85,
                          child: Text(
                            'You can always switch roles later in your profile settings.',
                            textAlign: TextAlign.center,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.muted,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  const _BlurredCircle({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.02)],
        ),
      ),
    );
  }
}
