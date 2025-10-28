import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/intro_anim_controller.dart';
import '../routes.dart';
import '../widgets/gradient_button.dart';
import '../widgets/logo_flip.dart';
import '../widgets/soft_background.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static const _slides = [
    _OnboardingSlide(
      title: 'Craft your next skill',
      subtitle:
          'Discover curated workshops from master artisans and learn practical techniques you can apply right away.',
      gradient: [Color(0xFF2CB9A8), Color(0xFF69D0C0)],
      accent: Color(0xFF1C6F65),
      icon: Icons.palette_outlined,
      highlights: ['Live sessions', 'Project kits'],
    ),
    _OnboardingSlide(
      title: 'Build a growth streak',
      subtitle:
          'Track your practice progress with streaks, milestones, and personalised reminders that keep you motivated.',
      gradient: [Color(0xFFE47D5C), Color(0xFFF6A87A)],
      accent: Color(0xFF9A4F33),
      icon: Icons.auto_graph_rounded,
      highlights: ['Daily goals', 'Smart tracking'],
    ),
    _OnboardingSlide(
      title: 'Thrive with community',
      subtitle:
          'Join a supportive network of mentors and learners to share ideas, feedback, and celebrate achievements.',
      gradient: [Color(0xFF5C7AF2), Color(0xFF8D9FF7)],
      accent: Color(0xFF2F3F8C),
      icon: Icons.groups_rounded,
      highlights: ['Mentor chats', 'Peer reviews'],
    ),
  ];

  late final IntroAnimController _controller;
  late final PageController _pageController;
  late final ValueNotifier<double> _pageNotifier;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(IntroAnimController(), tag: 'welcome');
    _pageController = PageController();
    _pageNotifier = ValueNotifier<double>(0);
    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null) {
        _pageNotifier.value = page;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.playIn(showBack: false);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageNotifier.dispose();
    if (Get.isRegistered<IntroAnimController>(tag: 'welcome')) {
      Get.delete<IntroAnimController>(tag: 'welcome');
    }
    super.dispose();
  }

  void _handleNext() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 420), curve: Curves.easeOutCubic);
    } else {
      Get.toNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SoftBackground(
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  right: 20,
                  top: 12,
                  child: FadeTransition(
                    opacity: _controller.headingFade,
                    child: SlideTransition(
                      position: _controller.headingSlide,
                      child: TextButton(
                        onPressed: () => Get.toNamed(Routes.login),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF2E6D63),
                          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        child: const Text('Skip'),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 6),
                        LogoFlip(controller: _controller, size: 112),
                        const SizedBox(height: 28),
                        FadeTransition(
                          opacity: _controller.headingFade,
                          child: SlideTransition(
                            position: _controller.headingSlide,
                            child: Column(
                              children: [
                                Text(
                                  'HunarHub',
                                  style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2E6D63),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Empower your artistry',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4D756F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        FadeTransition(
                          opacity: _controller.contentFade,
                          child: SlideTransition(
                            position: _controller.contentSlide,
                            child: SizedBox(
                              height: 400,
                              child: PageView.builder(
                                controller: _pageController,
                                physics: const BouncingScrollPhysics(),
                                onPageChanged: (index) => setState(() => _currentIndex = index),
                                itemCount: _slides.length,
                                itemBuilder: (context, index) {
                                  return ValueListenableBuilder<double>(
                                    valueListenable: _pageNotifier,
                                    builder: (_, page, __) {
                                      final progress = ((page - index).clamp(-1.0, 1.0) as num).toDouble();
                                      return _OnboardingSlideView(
                                        data: _slides[index],
                                        progress: progress,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        FadeTransition(
                          opacity: _controller.statsFade,
                          child: SlideTransition(
                            position: _controller.statsSlide,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(_slides.length, (index) {
                                final isActive = index == _currentIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 260),
                                  curve: Curves.easeOutCubic,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  height: 8,
                                  width: isActive ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: isActive ? const Color(0xFF2E6D63) : const Color(0xFFB5C7C3),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        FadeTransition(
                          opacity: _controller.ctaFade,
                          child: SlideTransition(
                            position: _controller.ctaSlide,
                            child: GradientButton(
                              label: _currentIndex == _slides.length - 1 ? 'Get Started' : 'Next',
                              onTap: _handleNext,
                              trailing: Icon(
                                _currentIndex == _slides.length - 1
                                    ? Icons.check_rounded
                                    : Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                              expand: true,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        FadeTransition(
                          opacity: _controller.statsFade,
                          child: SlideTransition(
                            position: _controller.statsSlide,
                            child: TextButton(
                              onPressed: () => Get.toNamed(Routes.login),
                              child: Text(
                                'Already a member? Log In',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF2E6D63),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

class _OnboardingSlide {
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final Color accent;
  final IconData icon;
  final List<String> highlights;

  const _OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.accent,
    required this.icon,
    required this.highlights,
  });
}

class _OnboardingSlideView extends StatelessWidget {
  final _OnboardingSlide data;
  final double progress;

  const _OnboardingSlideView({required this.data, required this.progress});

  @override
  Widget build(BuildContext context) {
    final translate = Tween<double>(begin: 0, end: 28).transform(progress.abs());
    final clamped = progress.clamp(-1.0, 1.0);
    final rotation = clamped * 0.06;
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..translate(translate * (progress > 0 ? -1 : 1), 0.0)
                  ..rotateZ(rotation),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: data.gradient,
                    ),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 38,
                        offset: Offset(0, 22),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 38,
                child: Transform.translate(
                  offset: Offset(clamped * 22, 0),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.82),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000),
                          blurRadius: 18,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Icon(
                      data.icon,
                      size: 44,
                      color: data.accent,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 44,
                left: 36,
                child: Transform.translate(
                  offset: Offset(clamped * -16, 0),
                  child: _HighlightChip(text: data.highlights.first, accent: data.accent),
                ),
              ),
              Positioned(
                bottom: 24,
                right: 36,
                child: Transform.translate(
                  offset: Offset(clamped * 18, 0),
                  child: _HighlightChip(text: data.highlights.last, accent: data.accent),
                ),
              ),
              Positioned(
                top: 36,
                right: 34,
                child: Opacity(
                  opacity: 0.65,
                  child: Transform.rotate(
                    angle: -math.pi / 9,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 90,
                child: Opacity(
                  opacity: 0.45,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2E6D63),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            height: 1.55,
            color: const Color(0xFF6D8781),
          ),
        ),
      ],
    );
  }
}

class _HighlightChip extends StatelessWidget {
  final String text;
  final Color accent;

  const _HighlightChip({required this.text, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 16, offset: Offset(0, 12)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: const Color(0xFF4C6F69),
            ),
          ),
        ],
      ),
    );
  }
}
