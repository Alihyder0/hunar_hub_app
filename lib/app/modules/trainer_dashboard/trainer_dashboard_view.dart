import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/brand_tile.dart';
import 'trainer_dashboard_controller.dart';

class TrainerDashboardView extends GetView<TrainerDashboardController> {
  const TrainerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isMobile = MediaQuery.of(context).size.width < 720;

    return Scaffold(
      extendBody: isMobile,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF9F4EC), Color(0xFFF1E4D6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -80,
            right: -40,
            child: _BlurredCircle(
              diameter: 220,
              color: AppColors.accent.withOpacity(0.18),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -60,
            child: _BlurredCircle(
              diameter: 280,
              color: AppColors.accentDeep.withOpacity(0.16),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = math.min(constraints.maxWidth, 1120.0);

                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      isMobile ? 20 : 24,
                      isMobile ? 20 : 24,
                      isMobile ? 20 : 24,
                      isMobile ? 160 : 32,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DashboardHeader(
                            textTheme: textTheme,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: isMobile ? 20 : 26),
                          _HighlightCard(
                            controller: controller,
                            textTheme: textTheme,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: isMobile ? 22 : 28),
                          _DashboardStats(
                            controller: controller,
                            textTheme: textTheme,
                          ),
                          SizedBox(height: isMobile ? 26 : 32),
                          _MyCoursesSection(
                            controller: controller,
                            textTheme: textTheme,
                            isMobile: isMobile,
                          ),
                          SizedBox(height: isMobile ? 24 : 28),
                          _RecentEnrollments(
                            controller: controller,
                            textTheme: textTheme,
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
      bottomNavigationBar: isMobile
          ? _TrainerBottomNavBar(
              controller: controller,
              textTheme: textTheme,
            )
          : null,
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.textTheme,
    required this.isMobile,
  });

  final TextTheme textTheme;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final titleStyle = (isMobile ? textTheme.titleLarge : textTheme.headlineSmall)?.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
    final subtitleStyle = textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const BrandTile(
                size: 52,
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              const _MobileHeaderActionButton(
                icon: Icons.notifications_active_outlined,
              ),
              const SizedBox(width: 10),
              const _MobileHeaderActionButton(
                icon: Icons.settings_outlined,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Trainer Dashboard',
            style: titleStyle,
          ),
          const SizedBox(height: 6),
          Text(
            'Monitor your courses, students, and earnings at a glance.',
            style: subtitleStyle,
          ),
        ],
      );
    }

    return Row(
      children: [
        const BrandTile(
          size: 64,
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trainer Dashboard',
                style: titleStyle,
              ),
              const SizedBox(height: 4),
              Text(
                'Monitor your courses, students, and earnings at a glance.',
                style: subtitleStyle,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_active_outlined),
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}

class _MobileHeaderActionButton extends StatelessWidget {
  const _MobileHeaderActionButton({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 22),
        color: AppColors.textSecondary,
        padding: const EdgeInsets.all(12),
        splashRadius: 28,
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({
    required this.controller,
    required this.textTheme,
    required this.isMobile,
  });

  final TrainerDashboardController controller;
  final TextTheme textTheme;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 28,
        vertical: isMobile ? 22 : 26,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4FC08D), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 26,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.greeting,
                      style: textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      controller.subGreeting,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.accentDeep,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle:
                          textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Create New Course'),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.greeting,
                        style: textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        controller.subGreeting,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.accentDeep,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                    textStyle:
                        textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Create New Course'),
                ),
              ],
            ),
    );
  }
}

class _DashboardStats extends StatelessWidget {
  const _DashboardStats({
    required this.controller,
    required this.textTheme,
  });

  final TrainerDashboardController controller;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = 1;
        if (constraints.maxWidth >= 960) {
          columns = 4;
        } else if (constraints.maxWidth >= 720) {
          columns = 3;
        } else if (constraints.maxWidth >= 520) {
          columns = 2;
        }
        final double spacing = 18;
        final double itemWidth =
            (constraints.maxWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: controller.stats
              .map(
                (stat) => _StatCard(
                  stat: stat,
                  width: itemWidth,
                  textTheme: textTheme,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.stat,
    required this.width,
    required this.textTheme,
  });

  final DashboardStatData stat;
  final double width;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: stat.backgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              stat.icon,
              color: stat.iconColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            stat.value,
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            stat.title,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            stat.change,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyCoursesSection extends StatelessWidget {
  const _MyCoursesSection({
    required this.controller,
    required this.textTheme,
    required this.isMobile,
  });

  final TrainerDashboardController controller;
  final TextTheme textTheme;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final headerContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Courses',
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Manage content, track progress and keep your learners engaged.',
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );

    final filterButton = TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.filter_list_rounded),
      label: const Text('Filters'),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentDeep,
        textStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) ...[
          headerContent,
          const SizedBox(height: 12),
          filterButton,
        ] else ...[
          Row(
            children: [
              Expanded(child: headerContent),
              filterButton,
            ],
          ),
        ],
        SizedBox(height: isMobile ? 16 : 20),
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = 1;
            if (constraints.maxWidth >= 1020) {
              columns = 3;
            } else if (constraints.maxWidth >= 720) {
              columns = 2;
            }
            final spacing = isMobile ? 16.0 : 20.0;
            final width =
                (constraints.maxWidth - (columns - 1) * spacing) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: controller.courses
                  .map(
                    (course) => _CourseCard(
                      course: course,
                      width: width,
                      textTheme: textTheme,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.width,
    required this.textTheme,
  });

  final TrainerCourseData course;
  final double width;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: course.accentColor.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  course.icon,
                  color: course.accentColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.category,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                course.price,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.accentDeep,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.star_rounded, color: Colors.amber.shade600, size: 20),
              const SizedBox(width: 4),
              Text(
                course.rating.toStringAsFixed(1),
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.group_outlined, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${course.learners} learners',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: course.completion,
              backgroundColor: const Color(0xFFECE3DA),
              valueColor: AlwaysStoppedAnimation<Color>(course.accentColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Course setup ${(course.completion * 100).round()}% complete',
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: course.accentColor,
                    foregroundColor: Colors.white,
                    textStyle: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(course.primaryActionLabel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: course.accentColor.withOpacity(0.4)),
                    foregroundColor: AppColors.textSecondary,
                    textStyle: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(course.secondaryActionLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentEnrollments extends StatelessWidget {
  const _RecentEnrollments({
    required this.controller,
    required this.textTheme,
  });

  final TrainerDashboardController controller;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Enrollments',
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Stay updated with new learners joining your courses today.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.accentDeep,
                  textStyle: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('View all'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          for (var i = 0; i < controller.recentEnrollments.length; i++)
            _EnrollmentTile(
              enrollment: controller.recentEnrollments[i],
              textTheme: textTheme,
              showDivider: i != controller.recentEnrollments.length - 1,
            ),
        ],
      ),
    );
  }
}

class _EnrollmentTile extends StatelessWidget {
  const _EnrollmentTile({
    required this.enrollment,
    required this.textTheme,
    required this.showDivider,
  });

  final RecentEnrollmentData enrollment;
  final TextTheme textTheme;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final initials = enrollment.learnerName
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Container(
      margin: EdgeInsets.only(bottom: showDivider ? 16 : 0),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFECE3DA),
                  width: 1,
                ),
              ),
            )
          : null,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.accent.withOpacity(0.18),
            child: Text(
              initials,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.accentDeep,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  enrollment.learnerName,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  enrollment.courseTitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: enrollment.statusColor.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  enrollment.status,
                  style: textTheme.bodySmall?.copyWith(
                    color: enrollment.statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                enrollment.enrolledAgo,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrainerBottomNavBar extends StatelessWidget {
  const _TrainerBottomNavBar({
    required this.controller,
    required this.textTheme,
  });

  final TrainerDashboardController controller;
  final TextTheme textTheme;

  static const List<_NavItemData> _items = [
    _NavItemData(icon: Icons.dashboard_rounded, label: 'Dashboard'),
    _NavItemData(icon: Icons.menu_book_outlined, label: 'Courses'),
    _NavItemData(icon: Icons.groups_rounded, label: 'Students'),
    _NavItemData(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
    _NavItemData(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Obx(() {
        final navChildren = <Widget>[];
        for (int i = 0; i < _items.length; i++) {
          navChildren.add(
            Expanded(
              child: _NavBarItem(
                data: _items[i],
                isSelected: controller.selectedNavIndex.value == i,
                onTap: () => controller.onNavItemTap(i),
                textTheme: textTheme,
              ),
            ),
          );
          if (i != _items.length - 1) {
            navChildren.add(const SizedBox(width: 6));
          }
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 22,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Row(children: navChildren),
        );
      }),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.data,
    required this.isSelected,
    required this.onTap,
    required this.textTheme,
  });

  final _NavItemData data;
  final bool isSelected;
  final VoidCallback onTap;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        isSelected ? AppColors.accentDeep : AppColors.textSecondary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent.withOpacity(0.16) : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.icon, color: iconColor, size: 24),
              const SizedBox(height: 6),
              SizedBox(
                height: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    data.label,
                    style: textTheme.labelSmall?.copyWith(
                      color: iconColor,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
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
