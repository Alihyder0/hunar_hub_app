import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import '../../widgets/staggered_fade_slide.dart';
import 'profile_completion_controller.dart';

class ProfileCompletionView extends GetView<ProfileCompletionController> {
  const ProfileCompletionView({super.key});

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
            bottom: -100,
            right: -40,
            child: _BlurredCircle(
              diameter: 280,
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
                        maxWidth: 640,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: controller.skipForNow,
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.textSecondary,
                                textStyle: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              child: const Text('Skip for now'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ScaleTransition(
                            scale: controller.iconScale,
                            child: FadeTransition(
                              opacity: controller.iconFade,
                              child: const BrandTile(
                                size: 92,
                                child: Icon(
                                  Icons.auto_fix_high_rounded,
                                  color: Colors.white,
                                  size: 42,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0,
                            end: 0.18,
                            child: Column(
                              children: [
                                Text(
                                  'Complete Your Profile',
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Showcase your expertise and credentials.',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Signed in as ${controller.email}',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.12,
                            end: 0.65,
                            offset: const Offset(0, 0.05),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Profile Picture',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Center(
                                    child: GestureDetector(
                                      onTap: controller.completeProfile,
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFF9F6F1),
                                          border: Border.all(
                                            color: AppColors.accent.withOpacity(0.4),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              color: AppColors.accentDeep,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Upload',
                                              style: textTheme.bodySmall?.copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    'Professional Title',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: controller.professionalTitleController,
                                    decoration: InputDecoration(
                                      hintText: 'e.g. Certified Graphic Design Trainer',
                                      filled: true,
                                      fillColor: const Color(0xFFF9F6F1),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 18,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.35),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                          color: AppColors.accent,
                                          width: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Professional Summary',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: controller.summaryController,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Share your experience, areas of expertise, and coaching style...',
                                      filled: true,
                                      fillColor: const Color(0xFFF9F6F1),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 18,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.35),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                          color: AppColors.accent,
                                          width: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  Text(
                                    'Your Skills',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Obx(
                                    () {
                                      final recommended = controller.availableSkills
                                          .map((skill) => _SkillChip(
                                                label: skill,
                                                selected: controller.selectedSkills.contains(skill),
                                                onSelected: () =>
                                                    controller.toggleSkill(skill),
                                                textTheme: textTheme,
                                              ))
                                          .toList();
                                      final custom = controller.customSkills
                                          .map((skill) => _SkillChip(
                                                label: skill,
                                                selected: controller.selectedSkills.contains(skill),
                                                onSelected: () =>
                                                    controller.toggleSkill(skill),
                                                onDeleted: () =>
                                                    controller.removeCustomSkill(skill),
                                                textTheme: textTheme,
                                              ))
                                          .toList();
                                      final chips = [...recommended, ...custom];
                                      if (chips.isEmpty) {
                                        return Text(
                                          'Add the skills you teach to help learners find you.',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        );
                                      }
                                      return Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: chips,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: controller.skillInputController,
                                    onSubmitted: (_) => controller.addSkillFromInput(),
                                    decoration: InputDecoration(
                                      hintText: 'Add a new skill',
                                      filled: true,
                                      fillColor: const Color(0xFFF9F6F1),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: controller.addSkillFromInput,
                                        icon: const Icon(Icons.add_circle_outline),
                                        color: AppColors.accentDeep,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.35),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                          color: AppColors.accent,
                                          width: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  Text(
                                    'Certifications',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Upload certifications or list credentials that back your expertise.',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Obx(
                                    () {
                                      if (controller.certifications.isEmpty) {
                                        return Text(
                                          'No certifications added yet.',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: AppColors.muted,
                                          ),
                                        );
                                      }
                                      return Column(
                                        children: controller.certifications
                                            .map(
                                              (certification) => Container(
                                                margin: const EdgeInsets.only(bottom: 12),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 18,
                                                  vertical: 14,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFF9F6F1),
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.muted.withOpacity(0.3),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.verified_outlined,
                                                      color: Colors.green,
                                                    ),
                                                    const SizedBox(width: 14),
                                                    Expanded(
                                                      child: Text(
                                                        certification,
                                                        style:
                                                            textTheme.bodyMedium?.copyWith(
                                                          color: AppColors.textPrimary,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () => controller
                                                          .removeCertification(certification),
                                                      icon: const Icon(Icons.close_rounded),
                                                      color: AppColors.muted,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: controller.certificationInputController,
                                    onSubmitted: (_) => controller.addCertification(),
                                    decoration: InputDecoration(
                                      hintText: 'Add certification or credential',
                                      filled: true,
                                      fillColor: const Color(0xFFF9F6F1),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: controller.addCertification,
                                        icon: const Icon(Icons.upload_file_outlined),
                                        color: AppColors.accentDeep,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.35),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: BorderSide(
                                          color: AppColors.muted.withOpacity(0.3),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        borderSide: const BorderSide(
                                          color: AppColors.accent,
                                          width: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          StaggeredFadeSlide(
                            controller: controller.contentController,
                            start: 0.6,
                            end: 0.9,
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: controller.completeProfile,
                                style: FilledButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  backgroundColor: AppColors.accent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                                child: const Text('Complete Profile'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
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

class _SkillChip extends StatelessWidget {
  const _SkillChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.textTheme,
    this.onDeleted,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final VoidCallback? onDeleted;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      selected: selected,
      onPressed: onSelected,
      onDeleted: onDeleted,
      deleteIcon: onDeleted != null
          ? const Icon(
              Icons.close_rounded,
              size: 18,
            )
          : null,
      deleteIconColor: Colors.white,
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: selected ? Colors.white : AppColors.textSecondary,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      ),
      side: BorderSide(
        color:
            selected ? AppColors.accent : AppColors.muted.withOpacity(0.3),
      ),
      selectedColor: AppColors.accent,
      backgroundColor: const Color(0xFFF9F6F1),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      showCheckmark: false,
    );
  }
}
