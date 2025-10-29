import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _iconController;
  late final AnimationController _contentController;
  late final Animation<double> _iconFlip;
  late final Animation<double> _headlineOpacity;
  late final Animation<Offset> _headlineOffset;
  late final Animation<double> _descriptionOpacity;
  late final Animation<Offset> _descriptionOffset;
  late final Animation<double> _topicsOpacity;
  late final Animation<Offset> _topicsOffset;
  late final Animation<double> _ctaOpacity;
  late final Animation<Offset> _ctaOffset;
  late final Animation<double> _statsOpacity;
  late final Animation<Offset> _statsOffset;

  final _topics = const [
    'Cooking',
    'Embroidery',
    'Repair & Tools',
    'Arts',
    'Jewel Making',
    'Handicrafts',
  ];

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _iconFlip = Tween<double>(
<<<<<<< ours
      begin: math.pi,
=======
      begin: -math.pi / 2,
>>>>>>> theirs
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: Curves.easeOutBack,
      ),
    );

    _headlineOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _headlineOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    _descriptionOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
    );
    _descriptionOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.15, 0.45, curve: Curves.easeOutCubic),
      ),
<<<<<<< ours
    );

    _topicsOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 0.65, curve: Curves.easeOut),
    );
    _topicsOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _ctaOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
    );
    _ctaOffset = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _statsOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );
    _statsOffset = Tween<Offset>(
=======
    );

    _topicsOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 0.65, curve: Curves.easeOut),
    );
    _topicsOffset = Tween<Offset>(
>>>>>>> theirs
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
<<<<<<< ours
        curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
      ),
    );

=======
        curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _ctaOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
    );
    _ctaOffset = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _statsOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );
    _statsOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
      ),
    );

>>>>>>> theirs
    _iconController.forward();
    _contentController.forward();
  }

  @override
  void dispose() {
    _iconController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleGetStarted() {
    _iconController
        .reverse()
        .then((_) => _iconController.forward()); // playful repeat
    Get.toNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9E7D8), Color(0xFFFDF6EE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
<<<<<<< ours
<<<<<<< HEAD
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.home),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    final progress = (_pageController.hasClients
                            ? (_pageController.page ?? 0)
                            : 0) -
                        index;
                    return _OnboardingSlide(
                      data: page,
                      progress: progress.toDouble(),
=======
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: [
                const SizedBox(height: 36),
                AnimatedBuilder(
                  animation: _iconFlip,
                  builder: (context, child) {
                    final value = _iconFlip.value;
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(value),
                      child: child,
>>>>>>> 308e16985b543385cb2a69d1b68108467e4405be
                    );
                  },
                  child: Hero(
                    tag: 'app-icon',
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2CB7A6), Color(0xFF48E0B3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
=======
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: math.max(0, constraints.maxHeight - 48),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      AnimatedBuilder(
                        animation: _iconFlip,
                        builder: (context, child) {
                          final value = _iconFlip.value;
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(value),
                            child: child,
                          );
                        },
                        child: Hero(
                          tag: 'app-icon',
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2CB7A6), Color(0xFF48E0B3)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x332AB1A6),
                                  blurRadius: 24,
                                  offset: Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 82,
                                  width: 82,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Icon(
                                    Icons.fiber_manual_record_outlined,
                                    size: 56,
                                    color: Color(0xFF2CB7A6),
                                  ),
                                ),
                                const Icon(
                                  Icons.gps_fixed_rounded,
                                  size: 40,
                                  color: Color(0xFFFA7D52),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      FadeTransition(
                        opacity: _headlineOpacity,
                        child: SlideTransition(
                          position: _headlineOffset,
                          child: Text(
                            'Empower Your Skills',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2B2A42),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeTransition(
                        opacity: _descriptionOpacity,
                        child: SlideTransition(
                          position: _descriptionOffset,
                          child: Text(
                            'Learn traditional crafts, connect with expert trainers, and master the art of handmade excellence.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFF5D5B6A),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeTransition(
                        opacity: _topicsOpacity,
                        child: SlideTransition(
                          position: _topicsOffset,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: _topics
                                .map(
                                  (topic) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x1A2AB1A6),
                                          blurRadius: 12,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 6,
                                          width: 6,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF2CB7A6),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          topic,
                                          style:
                                              theme.textTheme.labelLarge?.copyWith(
                                            color: const Color(0xFF2B2A42),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const Spacer(),
                      FadeTransition(
                        opacity: _ctaOpacity,
                        child: SlideTransition(
                          position: _ctaOffset,
                          child: SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: _handleGetStarted,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2CB7A6),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 6,
                                textStyle: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Get Started'),
                                  SizedBox(width: 12),
                                  Icon(Icons.arrow_forward_rounded),
                                ],
                              ),
                            ),
                          ),
>>>>>>> theirs
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x332AB1A6),
                            blurRadius: 24,
                            offset: Offset(0, 16),
                          ),
                        ],
                      ),
<<<<<<< ours
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 82,
                            width: 82,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.fiber_manual_record_outlined,
                              size: 56,
                              color: Color(0xFF2CB7A6),
                            ),
                          ),
                          const Icon(
                            Icons.gps_fixed_rounded,
                            size: 40,
                            color: Color(0xFFFA7D52),
                          ),
                        ],
=======
                      const SizedBox(height: 28),
                      FadeTransition(
                        opacity: _statsOpacity,
                        child: SlideTransition(
                          position: _statsOffset,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              _StatTile(label: 'Learners', value: '2.8K+'),
                              _StatTile(label: 'Trainers', value: '150+'),
                              _StatTile(label: 'Sessions', value: '5K+'),
                            ],
                          ),
                        ),
>>>>>>> theirs
                      ),
                    ],
                  ),
                ),
<<<<<<< ours
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _headlineOpacity,
                  child: SlideTransition(
                    position: _headlineOffset,
                    child: Text(
                      'Empower Your Skills',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2B2A42),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _descriptionOpacity,
                  child: SlideTransition(
                    position: _descriptionOffset,
                    child: Text(
                      'Learn traditional crafts, connect with expert trainers, and master the art of handmade excellence.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF5D5B6A),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _topicsOpacity,
                  child: SlideTransition(
                    position: _topicsOffset,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: _topics
                          .map(
                            (topic) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x1A2AB1A6),
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 6,
                                    width: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF2CB7A6),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    topic,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: const Color(0xFF2B2A42),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const Spacer(),
                FadeTransition(
                  opacity: _ctaOpacity,
                  child: SlideTransition(
                    position: _ctaOffset,
                    child: SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _handleGetStarted,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2CB7A6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 6,
                          textStyle: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Get Started'),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _statsOpacity,
                  child: SlideTransition(
                    position: _statsOffset,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _StatTile(label: 'Learners', value: '2.8K+'),
                        _StatTile(label: 'Trainers', value: '150+'),
                        _StatTile(label: 'Sessions', value: '5K+'),
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
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2B2A42),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: const Color(0xFF85839B),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
=======
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2B2A42),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: const Color(0xFF85839B),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
>>>>>>> theirs
