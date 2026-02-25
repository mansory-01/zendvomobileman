// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/features/gift_creation/domain/models/gift_review_summary.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/review_row_item.dart';

/// White card that renders the full gift summary table.
/// Extracts all display logic out of the page so the page stays thin.
class ReviewSummaryCard extends StatelessWidget {
  final GiftReviewSummary summary;

  const ReviewSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        border: Border.all(color: AppColors.lightInactiveBorder),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipient (two-line value: name + phone)
          ReviewRowItem(
            label: AppStrings.reviewRecipient,
            value: '${summary.recipientName}\n${summary.recipientPhone}',
          ),

          // Amount
          ReviewRowItem(
            label: AppStrings.reviewAmount,
            value: '\$${summary.amount.toInt()}',
          ),

          // Processing fee
          ReviewRowItem(
            label: AppStrings.reviewProcessingFee,
            value: '\$${summary.processingFee.toInt()}',
          ),

          // Total — prominent style
          ReviewRowItem(
            label: AppStrings.reviewTotalAmount,
            value: '\$${summary.totalAmount.toInt()}',
            valueStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.getHeadingTextColor(context),
            ),
          ),

          // Amount privacy
          ReviewRowItem(
            label: AppStrings.reviewAmountPrivacy,
            value: summary.hideAmount
                ? AppStrings.reviewHideAmountSent
                : 'Visible',
          ),

          // Sender privacy
          ReviewRowItem(
            label: AppStrings.reviewSenderPrivacy,
            value: summary.stayAnonymous ? AppStrings.reviewAnonymous : 'Named',
          ),

          // Unlock date and time
          ReviewRowItem(
            label: AppStrings.reviewUnlockDateTime,
            value: summary.unlockDateTime,
          ),

          // Message
          if (summary.message != null && summary.message!.isNotEmpty)
            ReviewRowItem(
              label: AppStrings.reviewMessageForSender,
              value: summary.message!,
              isMultiLine: true,
              showDivider: false,
            ),
        ],
      ),
    );
  }
}
