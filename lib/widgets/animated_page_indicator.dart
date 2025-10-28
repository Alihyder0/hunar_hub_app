import 'package:flutter/material.dart';

class AnimatedPageIndicator extends StatelessWidget {
  const AnimatedPageIndicator({
    super.key,
    required this.length,
    required this.activeIndex,
    this.activeColor = const Color(0xFF2AB1A6),
  });

  final int length;
  final int activeIndex;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 10,
          width: isActive ? 26 : 10,
          decoration: BoxDecoration(
            color: isActive
                ? activeColor
                : activeColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}
