import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late final AnimationController _contentController;
  late final Animation<double> _iconOpacity;
  late final Animation<Offset> _iconOffset;
  late final Animation<double> _headlineOpacity;
  late final Animation<Offset> _headlineOffset;
  late final Animation<double> _toggleOpacity;
  late final Animation<Offset> _toggleOffset;
  late final Animation<double> _formOpacity;
  late final Animation<Offset> _formOffset;
  late final Animation<double> _actionOpacity;
  late final Animation<Offset> _actionOffset;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _iconOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _iconOffset = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOutCubic),
      ),
    );

    _headlineOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.1, 0.4, curve: Curves.easeOut),
    );
    _headlineOffset = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.1, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _toggleOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
    );
    _toggleOffset = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _formOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.4, 0.75, curve: Curves.easeOut),
    );
    _formOffset = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.4, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _actionOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );
    _actionOffset = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.65, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF6EE), Color(0xFFF4E2D3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => Get.back(),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF5D5B6A),
                    textStyle: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  label: const Text('Back'),
                ),
                const SizedBox(height: 12),
                FadeTransition(
                  opacity: _iconOpacity,
                  child: SlideTransition(
                    position: _iconOffset,
                    child: Center(
                      child: Hero(
                        tag: 'app-icon',
                        child: Container(
                          height: 92,
                          width: 92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2CB7A6), Color(0xFF48E0B3)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x262CB7A6),
                                blurRadius: 20,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.fiber_manual_record_outlined,
                                  size: 38,
                                  color: Color(0xFF2CB7A6),
                                ),
                              ),
                              const Icon(
                                Icons.gps_fixed_rounded,
                                size: 30,
                                color: Color(0xFFFA7D52),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _headlineOpacity,
                  child: SlideTransition(
                    position: _headlineOffset,
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back!',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2B2A42),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Login to continue your journey',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B6982),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _toggleOpacity,
                  child: SlideTransition(
                    position: _toggleOffset,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x142CB7A6),
                            blurRadius: 16,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _LoginToggleChip(
                            label: 'Email',
                            isSelected: _selectedTab == 0,
                            onTap: () => setState(() => _selectedTab = 0),
                          ),
                          const SizedBox(width: 8),
                          _LoginToggleChip(
                            label: 'Phone',
                            isSelected: _selectedTab == 1,
                            onTap: () => setState(() => _selectedTab = 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _formOpacity,
                  child: SlideTransition(
                    position: _formOffset,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A2CB7A6),
                            blurRadius: 24,
                            offset: Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LoginField(
                            label: _selectedTab == 0
                                ? 'Email Address'
                                : 'Phone Number',
                            hint: _selectedTab == 0
                                ? 'Enter your email'
                                : 'Enter your phone',
                            keyboardType: _selectedTab == 0
                                ? TextInputType.emailAddress
                                : TextInputType.phone,
                          ),
                          const SizedBox(height: 18),
                          const _LoginField(
                            label: 'Password',
                            hint: 'Enter your password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF2CB7A6),
                                textStyle: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _actionOpacity,
                  child: SlideTransition(
                    position: _actionOffset,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2CB7A6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 6,
                              textStyle: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Login'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF6B6982),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF2CB7A6),
                                textStyle: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'By continuing, you agree to our Terms & Privacy Policy',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF8E8CA6),
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

class _LoginToggleChip extends StatelessWidget {
  const _LoginToggleChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: isSelected
                ? const Color(0xFF2CB7A6)
                : Colors.transparent,
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x332CB7A6),
                      blurRadius: 16,
                      offset: Offset(0, 12),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF6B6982),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF5D5B6A),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF7F4F1),
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
