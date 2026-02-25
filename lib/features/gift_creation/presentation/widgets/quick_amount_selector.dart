import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/amount_chip.dart';

/// Displays a grid of quick-amount chip buttons.
/// Preset amounts follow the design: \$10, \$20, \$50, \$100, \$200, \$500.
class QuickAmountSelector extends StatelessWidget {
  final double? selectedAmount;
  final ValueChanged<double> onAmountSelected;

  static const List<double> _presets = [10, 20, 50, 100, 200, 500];

  const QuickAmountSelector({
    super.key,
    required this.onAmountSelected,
    this.selectedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.s,
      mainAxisSpacing: AppSpacing.s,
      childAspectRatio: 2.5,
      children: _presets
          .map(
            (amount) => AmountChip(
              amount: amount,
              isSelected: selectedAmount == amount,
              onTap: onAmountSelected,
            ),
          )
          .toList(),
    );
  }
}
