// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/features/gift_creation/domain/models/recipient_model.dart';

/// Displays a resolved recipient after a phone lookup.
/// Shows avatar initials, phone number, and display name.
class RecipientCard extends StatelessWidget {
  final RecipientModel recipient;

  const RecipientCard({super.key, required this.recipient});

  String get _initials {
    final parts = recipient.displayName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return recipient.displayName.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.s + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightFieldBackground,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        border: Border.all(color: AppColors.lightInactiveBorder),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.m),

          // Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipient.phoneNumber,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.lightTextHeading,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                recipient.displayName,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.lightTextBody.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
