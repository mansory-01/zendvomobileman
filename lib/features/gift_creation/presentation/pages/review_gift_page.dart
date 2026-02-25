// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/features/gift_creation/domain/models/gift_review_summary.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/review_legal_text.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/review_summary_card.dart';

/// "Review Gift Details" screen.
///
/// Expects the [GiftCreationBloc] already to be in scope (provided by the
/// parent navigator / shell or by wrapping with BlocProvider at the route level).
///
/// Pass a pre-built [GiftReviewSummary] when pushing this route so the screen
/// is decoupled from the form state and easy to test in isolation:
///
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (_) => BlocProvider.value(
///       value: context.read<GiftCreationBloc>(),
///       child: ReviewGiftPage(summary: summaryFromFormState),
///     ),
///   ),
/// );
/// ```
class ReviewGiftPage extends StatelessWidget {
  final GiftReviewSummary summary;

  const ReviewGiftPage({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiftCreationBloc, GiftCreationState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        final isLoading = state is GiftCreationLoading;

        return Scaffold(
          backgroundColor: AppColors.getBackgroundColor(context),
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: AppSpacing.l),
                        ReviewSummaryCard(summary: summary),
                        const SizedBox(height: AppSpacing.l),
                        Center(
                          child: ReviewLegalText(
                            onTermsTap: () {
                              // TODO: Navigate to Terms screen or open URL
                            },
                            onPrivacyTap: () {
                              // TODO: Navigate to Privacy Policy screen or open URL
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),

                // ── Sticky Proceed button ─────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.m,
                    AppSpacing.s,
                    AppSpacing.m,
                    AppSpacing.m,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.getBackgroundColor(context),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: AppButton(
                    text: AppStrings.proceedButton,
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () => context.read<GiftCreationBloc>().add(
                            const ProceedGiftPayment(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  void _handleStateChanges(BuildContext context, GiftCreationState state) {
    if (state is GiftCreationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment confirmed! Code: ${state.giftCode}'),
          backgroundColor: AppColors.success,
        ),
      );
      // TODO: Navigate to payment success / gift tracking screen
    } else if (state is GiftCreationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.getBackgroundColor(context),
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.vignette, color: Colors.white, size: 20),
        ),
      ),
      title: const Text(
        'Dashboard',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextHeading,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.lightTextHeading),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.reviewGiftTitle,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.reviewGiftSubtitle,
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: AppColors.getBodyTextColor(context).withOpacity(0.65),
          ),
        ),
      ],
    );
  }
}
