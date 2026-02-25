import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

/// A single quick-amount chip button (e.g. \$10, \$20, \$50).
class AmountChip extends StatelessWidget {
  final double amount;
  final bool isSelected;
  final ValueChanged<double> onTap;

  const AmountChip({
    super.key,
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(amount),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.lightBackground,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.lightInactiveBorder,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        ),
        child: Text(
          '\$${amount.toInt()}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.lightTextHeading,
          ),
        ),
      ),
    );
  }
}
