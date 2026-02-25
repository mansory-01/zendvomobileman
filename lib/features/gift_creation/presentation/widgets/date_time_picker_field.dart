// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';

/// A read-only field that shows a date or time value and opens a picker on tap.
/// Matches the rounded input style used throughout the app.
class DateTimePickerField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? value;
  final VoidCallback onTap;
  final IconData trailingIcon;

  const DateTimePickerField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onTap,
    required this.trailingIcon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = (value != null && value!.isNotEmpty)
        ? value!
        : hintText;
    final isPlaceholder = value == null || value!.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty) ...[
          Text(
            labelText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.getBodyTextColor(context).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              border: Border.all(color: AppColors.lightInactiveBorder),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isPlaceholder
                          ? FontWeight.w400
                          : FontWeight.w500,
                      color: isPlaceholder
                          ? AppColors.lightTextBody.withOpacity(0.4)
                          : AppColors.lightTextHeading,
                    ),
                  ),
                ),
                Icon(
                  trailingIcon,
                  size: 20,
                  color: AppColors.lightTextBody.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
