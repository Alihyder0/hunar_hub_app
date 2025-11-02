import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/login_text_field.dart';
import '../../widgets/login_toggle.dart';
import '../../widgets/staggered_fade_slide.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final minHeight = math.max(constraints.maxHeight - 48, 0.0);
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: Get.back,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ScaleTransition(
                        scale: controller.iconScale,
                        child: FadeTransition(
                          opacity: controller.iconFade,
                          child: const BrandTile(
                            child: Icon(
                              Icons.track_changes_rounded,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0,
                        end: 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back!',
                              style: textTheme.headlineSmall?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Login to continue your journey',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.1,
                          end: 0.35,
                          child: LoginToggle(
                            selectedIndex: controller.loginMethod.value,
                            onChanged: controller.selectLoginMethod,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0.2,
                        end: 0.45,
                        child: const LoginTextField(
                          label: 'Email Address',
                          hint: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(height: 16),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0.3,
                        end: 0.55,
                        child: const LoginTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0.4,
                        end: 0.6,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0.5,
                        end: 0.75,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0.6,
                        end: 0.85,
                        child: Center(
                          child: GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.signupRole),
                            behavior: HitTestBehavior.opaque,
                            child: Text.rich(
                              TextSpan(
                                style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                children: const [
                                  TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Spacer(),
                      StaggeredFadeSlide(
                        controller: controller.contentController,
                        start: 0.7,
                        end: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'By continuing, you agree to our Terms & Privacy Policy',
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.muted,
                            ),
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}
