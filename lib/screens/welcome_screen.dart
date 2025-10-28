import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/intro_anim_controller.dart';
import '../widgets/logo_flip.dart';
import '../routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Bind a fresh controller for this screen
    final c = Get.put(IntroAnimController());

    // Kick the sequence after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.playIn(showBack: false);
    });

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                // Logo flips in
                const LogoFlip(),
                const SizedBox(height: 16),

                // Title + subtitle fade/slide up as "content"
                AnimatedBuilder(
                  animation: c.contentCtrl,
                  builder: (_, __) {
                    return Opacity(
                      opacity: c.contentFade.value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - c.contentFade.value)),
                        child: Column(
                          children: [
                            Text(
                              'HunarHub',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2E6D63),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                'Empower Your Skills',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xFF4E746F),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Example “chips”
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: const [
                                _Chip(text: 'Cooking', icon: Icons.search),
                                _Chip(text: 'Embroidery', icon: Icons.emoji_emotions),
                                _Chip(text: 'Repair & Tools', icon: Icons.build),
                                _Chip(text: 'Arts', icon: Icons.palette),
                                _Chip(text: 'Jewel Making', icon: Icons.diamond),
                                _Chip(text: 'Handicrafts', icon: Icons.handyman),
                              ],
                            ),

                            const SizedBox(height: 26),

                            // Gradient CTA
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.login),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFF2AB1A6), Color(0xFFE07B58)],
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Get Started',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_right_alt, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Stats row (optional)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _Stat(label: 'Learners', value: '2.8K+'),
                                const SizedBox(width: 28),
                                _Stat(label: 'Trainers', value: '150+'),
                                const SizedBox(width: 28),
                                _Stat(label: 'Skills', value: '50+'),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Chip({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF5E7B77)),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Color(0xFF5E7B77))),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF2E6D63))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF5E7B77))),
      ],
    );
  }
}
