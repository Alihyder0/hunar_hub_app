import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BrandTile extends StatelessWidget {
  const BrandTile({super.key, required this.child, this.size = 110});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: AppColors.brandGradient,
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
