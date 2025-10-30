import 'package:flutter/material.dart';

class StaggeredFadeSlide extends StatelessWidget {
  const StaggeredFadeSlide({
    super.key,
    required this.controller,
    required this.start,
    required this.end,
    required this.child,
    this.offset = const Offset(0, 0.08),
  });

  final AnimationController controller;
  final double start;
  final double end;
  final Widget child;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final animationCurve = Interval(start, end, curve: Curves.easeOut);
    final fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: animationCurve,
    );
    final slideAnimation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: animationCurve,
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
