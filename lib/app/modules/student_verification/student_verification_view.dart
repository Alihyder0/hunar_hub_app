import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/staggered_fade_slide.dart';
import 'student_verification_controller.dart';

class StudentVerificationView extends GetView<StudentVerificationController> {
  const StudentVerificationView({super.key});

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
            top: -60,
            left: -40,
            child: _BlurredCircle(
              diameter: 200,
              color: AppColors.accent.withOpacity(0.18),
            ),
          ),
          Positioned(
            bottom: -90,
            right: -20,
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
                        maxWidth: 520,
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
                                  Icons.mark_email_read_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.08,
                            end: 0.28,
                            child: Column(
                              children: [
                                Text(
                                  'Verify Your Email',
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "We've sent a 6-digit verification code to",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.email,
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.2,
                            end: 0.65,
                            offset: const Offset(0, 0.05),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 32,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 28,
                                    offset: const Offset(0, 18),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Verification Code',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    alignment: WrapAlignment.center,
                                    children: List.generate(6, (index) {
                                      return _OtpDigitField(
                                        controller: controller.otpControllers[index],
                                        focusNode: controller.otpFocusNodes[index],
                                        onChanged: (value) =>
                                            controller.onOtpChanged(value, index),
                                        onSubmitted: () =>
                                            controller.onOtpSubmitted(index),
                                        isLast: index == 5,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 28),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: controller.verifyCode,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        backgroundColor: AppColors.accent,
                                        foregroundColor: Colors.white,
                                        textStyle: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text('Verify Email'),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: "Didn't receive the code? ",
                                        ),
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: TextButton(
                                            onPressed: controller.resendCode,
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(0, 0),
                                              tapTargetSize:
                                                  MaterialTapTargetSize.shrinkWrap,
                                              foregroundColor:
                                                  AppColors.accentDeep,
                                              textStyle:
                                                  textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            child: const Text('Resend'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }
}

class _OtpDigitField extends StatelessWidget {
  const _OtpDigitField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
    this.isLast = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 52,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: AppColors.accent,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF7F4EE),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
        onSubmitted: (_) => onSubmitted(),
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        inputFormatters:  [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
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
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 60,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}
