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
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Stack(
          children: [
            const _BackgroundGlow(
              diameter: 320,
              alignment: Alignment(-0.95, -1.0),
              colors: [Color(0xFFFFF1E5), Colors.transparent],
            ),
            const _BackgroundGlow(
              diameter: 280,
              alignment: Alignment(0.95, -0.6),
              colors: [Color(0xFFDDF4EA), Colors.transparent],
            ),
            const _BackgroundGlow(
              diameter: 340,
              alignment: Alignment(0.8, 1.0),
              colors: [Color(0xFFFFFFFF), Colors.transparent],
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
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
                              size: 44,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.05,
                          end: 0.22,
                          child: Text(
                            'HunarHub',
                            textAlign: TextAlign.center,
                            style: textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.14,
                          end: 0.32,
                          child: Text(
                            'Empower Your Skills',
                            textAlign: TextAlign.center,
                            style: textTheme.headlineSmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.24,
                          end: 0.44,
                          child: Text(
                            'Learn traditional crafts, connect with expert trainers, and master the art of handmade excellence.',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.34,
                          end: 0.6,
                          child: Wrap(
                            spacing: 14,
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
                        const SizedBox(height: 36),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.45,
                          end: 0.72,
                          child: ScaleTransition(
                            scale: controller.buttonScale,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonGradient,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x334FC08D),
                                    offset: Offset(0, 16),
                                    blurRadius: 32,
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(28),
                                  onTap: controller.onGetStartedTap,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 36,
                                      vertical: 18,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Get Started',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 42),
                        StaggeredFadeSlide(
                          controller: controller.contentController,
                          start: 0.6,
                          end: 0.9,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x143F2E2C),
                                  blurRadius: 36,
                                  offset: Offset(0, 18),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                StatTile(label: 'Learners', value: '2.8K+'),
                                _StatDivider(),
                                StatTile(label: 'Trainers', value: '150+'),
                                _StatDivider(),
                                StatTile(label: 'Courses', value: '320+'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow({
    required this.diameter,
    required this.alignment,
    required this.colors,
  });

  final double diameter;
  final Alignment alignment;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: colors,
            radius: 0.8,
          ),
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.muted.withOpacity(0.0),
            AppColors.muted.withOpacity(0.45),
            AppColors.muted.withOpacity(0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
