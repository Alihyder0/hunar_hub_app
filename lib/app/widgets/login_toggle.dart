import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LoginToggle extends StatelessWidget {
  const LoginToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

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
          _buildOption(context, 'Email', 0),
          _buildOption(context, 'Phone', 1),
        ],
      ),
    );
  }

  Expanded _buildOption(BuildContext context, String label, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : Colors.transparent,
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
                  color:
                      isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
