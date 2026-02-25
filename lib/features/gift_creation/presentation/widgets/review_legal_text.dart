// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_strings.dart';

/// "By proceeding, you have accepted [Zendvo terms] and [Privacy Policy]"
/// Both links are tappable with customisable callbacks.
class ReviewLegalText extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const ReviewLegalText({super.key, this.onTermsTap, this.onPrivacyTap});

  @override
  Widget build(BuildContext context) {
    const linkStyle = TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      fontSize: 13,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.primary,
    );
    final muted = TextStyle(
      color: AppColors.getBodyTextColor(context).withOpacity(0.65),
      fontSize: 13,
      height: 1.6,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: AppStrings.reviewLegalPrefix, style: muted),
          WidgetSpan(
            child: GestureDetector(
              onTap: onTermsTap,
              child: Text(AppStrings.reviewZendvoTerms, style: linkStyle),
            ),
          ),
          TextSpan(text: AppStrings.reviewLegalMid, style: muted),
          WidgetSpan(
            child: GestureDetector(
              onTap: onPrivacyTap,
              child: Text(AppStrings.reviewPrivacyPolicy, style: linkStyle),
            ),
          ),
        ],
      ),
    );
  }
}
