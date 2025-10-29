import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const HunarHubApp());
}

class HunarHubApp extends StatelessWidget {
  const HunarHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hunar Hub',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const _OnboardingScreen(),
    );
  }
}

class _OnboardingScreen extends StatefulWidget {
  const _OnboardingScreen();

  @override
  State<_OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<_OnboardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _flipController;
  late final AnimationController _contentController;
  late final Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _flipAnimation = Tween<double>(
      begin: math.pi / 2,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.easeOutBack,
      ),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _flipController.forward();
        _contentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _goToLogin() async {
    if (_flipController.isAnimating) return;
    await _flipController.reverse();
    await Get.to(() => const _LoginScreen(), transition: Transition.fadeIn);
    if (!mounted) return;
    _flipController.forward();
    _contentController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _flipAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateY(_flipAnimation.value),
                      child: child,
                    );
                  },
                  child: const _GradientTile(
                    child: Icon(
                      Icons.track_changes_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _StaggeredFadeSlide(
                  controller: _contentController,
                  start: 0.05,
                  end: 0.25,
                  child: Text(
                    'Empower Your Skills',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFF3F2E2C),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 12),
                _StaggeredFadeSlide(
                  controller: _contentController,
                  start: 0.18,
                  end: 0.38,
                  child: Text(
                    'Learn traditional crafts, connect with expert trainers, and master the art of handmade excellence.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF7A655F),
                          height: 1.5,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                _StaggeredFadeSlide(
                  controller: _contentController,
                  start: 0.3,
                  end: 0.6,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: const [
                      _SkillChip(label: 'Cooking'),
                      _SkillChip(label: 'Embroidery'),
                      _SkillChip(label: 'Repair & Tools'),
                      _SkillChip(label: 'Arts'),
                      _SkillChip(label: 'Jewel Making'),
                      _SkillChip(label: 'Handicrafts'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _StaggeredFadeSlide(
                  controller: _contentController,
                  start: 0.45,
                  end: 0.7,
                  child: FilledButton.icon(
                    onPressed: _goToLogin,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4FC08D),
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
                const SizedBox(height: 36),
                _StaggeredFadeSlide(
                  controller: _contentController,
                  start: 0.6,
                  end: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _StatTile(label: 'Learners', value: '2.8K+'),
                      _StatTile(label: 'Trainers', value: '150+'),
                      _StatTile(label: 'Courses', value: '320+'),
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

class _LoginScreen extends StatefulWidget {
  const _LoginScreen();

  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> with TickerProviderStateMixin {
  late final AnimationController _iconController;
  late final AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) {
        _contentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final minHeight = math.max(constraints.maxHeight - 48, 0.0);
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: Get.back,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFF3F2E2C),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Builder(
                      builder: (context) {
                        final fadeAnimation = CurvedAnimation(
                          parent: _iconController,
                          curve: Curves.easeOut,
                        );
                        return ScaleTransition(
                          scale: CurvedAnimation(
                            parent: _iconController,
                            curve: Curves.easeOutBack,
                          ),
                          child: FadeTransition(
                            opacity: fadeAnimation,
                            child: const _GradientTile(
                              child: Icon(
                                Icons.track_changes_rounded,
                                color: Colors.white,
                                size: 42,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0,
                      end: 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: textTheme.headlineSmall?.copyWith(
                              color: const Color(0xFF3F2E2C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Login to continue your journey',
                            style: textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF7A655F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.1,
                      end: 0.35,
                      child: _LoginToggle(),
                    ),
                    const SizedBox(height: 20),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.2,
                      end: 0.45,
                      child: const _LoginTextField(
                        label: 'Email Address',
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.3,
                      end: 0.55,
                      child: const _LoginTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.4,
                      end: 0.6,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.5,
                      end: 0.75,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: const Color(0xFF4FC08D),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.6,
                      end: 0.85,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF7A655F),
                            ),
                            children: const [
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3F2E2C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Spacer(),
                    _StaggeredFadeSlide(
                      controller: _contentController,
                      start: 0.7,
                      end: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          'By continuing, you agree to our Terms & Privacy Policy',
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFFB39B92),
                          ),
                          textAlign: TextAlign.center,
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
    );
  }
}

class _GradientTile extends StatelessWidget {
  const _GradientTile({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF4FC08D), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x403F2E2C),
            offset: Offset(0, 16),
            blurRadius: 32,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A3F2E2C),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF3F2E2C),
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3F2E2C),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: const Color(0xFF7A655F),
          ),
        ),
      ],
    );
  }
}

class _StaggeredFadeSlide extends StatelessWidget {
  const _StaggeredFadeSlide({
    required this.controller,
    required this.start,
    required this.end,
    required this.child,
  });

  final AnimationController controller;
  final double start;
  final double end;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, slideAnimation.value.dy * 100),
            child: child,
          ),
        );
      },
    );
  }
}

class _LoginToggle extends StatefulWidget {
  @override
  State<_LoginToggle> createState() => _LoginToggleState();
}

class _LoginToggleState extends State<_LoginToggle> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          _buildOption('Email', 0),
          _buildOption('Phone', 1),
        ],
      ),
    );
  }

  Expanded _buildOption(String label, int index) {
    final isSelected = _selected == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selected = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4FC08D)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x333F2E2C),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected ? Colors.white : const Color(0xFF7A655F),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFF7A655F),
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
