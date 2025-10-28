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
  static const _skills = [
    _SkillData(Icons.restaurant_menu_rounded, 'Cooking'),
    _SkillData(Icons.pattern_rounded, 'Embroidery'),
    _SkillData(Icons.build_rounded, 'Repair & Tools'),
    _SkillData(Icons.brush_rounded, 'Arts & Crafts'),
    _SkillData(Icons.diamond_rounded, 'Jewellery'),
    _SkillData(Icons.handyman_rounded, 'Handloom'),
  ];

  static const _stats = [
    _StatData('2.8K+', 'Learners'),
    _StatData('150+', 'Mentors'),
    _StatData('50+', 'Skill Tracks'),
  ];

  late final IntroAnimController _controller;
  late final List<Animation<double>> _chipFades;
  late final List<Animation<Offset>> _chipSlides;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(IntroAnimController(), tag: 'welcome');

    _chipFades = List.generate(
      _skills.length,
      (index) => _controller.intervalAnimation(0.32 + index * 0.06, 0.62 + index * 0.06),
    );
    _chipSlides = List.generate(
      _skills.length,
      (index) => _controller.slideAnimation(
        0.32 + index * 0.06,
        0.62 + index * 0.06,
        offset: const Offset(0, 0.25),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.playIn(showBack: false);
    });
  }

  @override
  void dispose() {
    if (Get.isRegistered<IntroAnimController>(tag: 'welcome')) {
      Get.delete<IntroAnimController>(tag: 'welcome');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SoftBackground(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
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
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2E6D63),
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Empower Your Skills',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF446B66),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    FadeTransition(
                      opacity: _controller.subheadingFade,
                      child: SlideTransition(
                        position: _controller.subheadingSlide,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            'Learn traditional crafts, connect with expert trainers, and master the art of handmade excellence.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF6D8781),
                              fontSize: 13.5,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                    AnimatedBuilder(
                      animation: _controller.contentCtrl,
                      builder: (_, __) {
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: List.generate(_skills.length, (index) {
                            final data = _skills[index];
                            return FadeTransition(
                              opacity: _chipFades[index],
                              child: SlideTransition(
                                position: _chipSlides[index],
                                child: _SkillChip(data: data),
                              ),
                            );
                          }),
                        );
                      },
                    ),

                    const SizedBox(height: 36),
                    FadeTransition(
                      opacity: _controller.ctaFade,
                      child: SlideTransition(
                        position: _controller.ctaSlide,
                        child: GradientButton(
                          label: 'Get Started',
                          onTap: () => Get.toNamed(Routes.login),
                          trailing: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _controller.statsFade,
                      child: SlideTransition(
                        position: _controller.statsSlide,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < _stats.length; i++) ...[
                              _StatBadge(data: _stats[i]),
                              if (i != _stats.length - 1) const SizedBox(width: 26),
                            ]
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _controller.statsFade,
                      child: SlideTransition(
                        position: _controller.statsSlide,
                        child: Text(
                          'Your craft, our community.',
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF768F89),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillData {
  final IconData icon;
  final String label;
  const _SkillData(this.icon, this.label);
}

class _SkillChip extends StatelessWidget {
  final _SkillData data;
  const _SkillChip({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(color: Color(0x15000000), blurRadius: 18, offset: Offset(0, 10)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2CB9A8), Color(0xFFE47D5C)],
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(data.icon, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Text(
            data.label,
            style: GoogleFonts.poppins(
              color: const Color(0xFF4C6F69),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatData {
  final String value;
  final String label;
  const _StatData(this.value, this.label);
}

class _StatBadge extends StatelessWidget {
  final _StatData data;
  const _StatBadge({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Color(0x15000000), blurRadius: 16, offset: Offset(0, 10)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xFF2E6D63),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6D8781),
            ),
          ),
        ],
      ),
    );
  }
}
