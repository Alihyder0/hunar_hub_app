import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';
import '../widgets/animated_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  int _currentPage = 0;
  late final AnimationController _ctaController;
  late final Animation<double> _ctaAnimation;

  final _pages = const [
    _OnboardingData(
      title: 'Design your next big idea',
      description:
          'Discover curated lessons, motion references, and ready-to-use design kits crafted by leading creatives.',
      accentColor: Color(0xFF2AB1A6),
      gradient: [Color(0xFF2AB1A6), Color(0xFF6BE3D3)],
      icon: Icons.bolt_rounded,
    ),
    _OnboardingData(
      title: 'Collaborate with mentors',
      description:
          'Book live critiques, share prototypes, and receive actionable feedback through immersive sessions.',
      accentColor: Color(0xFFFCB62B),
      gradient: [Color(0xFFFCB62B), Color(0xFFFFE6A4)],
      icon: Icons.group_work_rounded,
    ),
    _OnboardingData(
      title: 'Launch stunning experiences',
      description:
          'Craft polished handoffs, export animation specs, and bring pixel-perfect experiences to market.',
      accentColor: Color(0xFF5C5BEB),
      gradient: [Color(0xFF5C5BEB), Color(0xFFA29BFE)],
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ctaController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _ctaAnimation = CurvedAnimation(
      parent: _ctaController,
      curve: Curves.easeOutBack,
    );
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
        _ctaController
          ..reset()
          ..forward();
      }
    });
    _ctaController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _ctaController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_currentPage == _pages.length - 1) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _pages[_currentPage].gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
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
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              AnimatedPageIndicator(
                length: _pages.length,
                activeIndex: _currentPage,
                activeColor: Colors.white,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ScaleTransition(
                  scale: _ctaAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _pages[_currentPage].accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        textStyle: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _handleContinue,
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get started' : 'Next',
                      ),
                    ),
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

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.data, required this.progress});

  final _OnboardingData data;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slideOffset = Tween<double>(begin: 40, end: 0)
        .transform((1 - progress.abs()).clamp(0.0, 1.0));
    final opacity = (1 - progress.abs()).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Column(
        children: [
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: opacity),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, slideOffset * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.4,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: const Alignment(0, -0.3),
                      child: Icon(
                        data.icon,
                        size: 140,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.85, 0.85),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.18),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(-0.85, 0.85),
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.description,
    required this.accentColor,
    required this.gradient,
    required this.icon,
  });

  final String title;
  final String description;
  final Color accentColor;
  final List<Color> gradient;
  final IconData icon;
}
