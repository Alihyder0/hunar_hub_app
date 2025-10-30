import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/skill_chip.dart';
import '../../widgets/staggered_fade_slide.dart';
import '../../widgets/stat_tile.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: controller.flipAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateY(controller.flipAnimation.value),
                      child: child,
                    );
                  },
                  child: const BrandTile(
                    child: Icon(
                      Icons.track_changes_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                StaggeredFadeSlide(
                  controller: controller.contentController,
                  start: 0.05,
                  end: 0.25,
                  child: Text(
                    'Empower Your Skills',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                StaggeredFadeSlide(
                  controller: controller.contentController,
                  start: 0.18,
                  end: 0.38,
                  child: Text(
                    'Learn traditional crafts, connect with expert trainers, and master the art of handmade excellence.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                StaggeredFadeSlide(
                  controller: controller.contentController,
                  start: 0.3,
                  end: 0.6,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: const [
                      SkillChip(label: 'Cooking'),
                      SkillChip(label: 'Embroidery'),
                      SkillChip(label: 'Repair & Tools'),
                      SkillChip(label: 'Arts'),
                      SkillChip(label: 'Jewel Making'),
                      SkillChip(label: 'Handicrafts'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                StaggeredFadeSlide(
                  controller: controller.contentController,
                  start: 0.45,
                  end: 0.7,
                  child: ScaleTransition(
                    scale: controller.buttonScale,
                    child: FilledButton.icon(
                      onPressed: controller.onGetStartedTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Get Started'),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                StaggeredFadeSlide(
                  controller: controller.contentController,
                  start: 0.6,
                  end: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      StatTile(label: 'Learners', value: '2.8K+'),
                      StatTile(label: 'Trainers', value: '150+'),
                      StatTile(label: 'Courses', value: '320+'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
