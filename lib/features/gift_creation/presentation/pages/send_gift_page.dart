// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_bloc.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_event.dart';
import 'package:zendvo/features/gift_creation/presentation/bloc/gift_creation_state.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/date_time_picker_field.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/gift_option_checkbox.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/phone_input_field.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/quick_amount_selector.dart';
import 'package:zendvo/features/gift_creation/presentation/widgets/recipient_card.dart';

/// "Send a Gift" screen.
///
/// Provides the BLoC and composes all form sections.
/// Navigation into this screen should wrap it with [BlocProvider]:
///
/// ```dart
/// BlocProvider(
///   create: (_) => GiftCreationBloc(),
///   child: const SendGiftPage(),
/// )
/// ```
class SendGiftPage extends StatelessWidget {
  const SendGiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GiftCreationBloc(),
      child: const _SendGiftView(),
    );
  }
}

class _SendGiftView extends StatefulWidget {
  const _SendGiftView();

  @override
  State<_SendGiftView> createState() => _SendGiftViewState();
}

class _SendGiftViewState extends State<_SendGiftView> {
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GiftCreationBloc, GiftCreationState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        final formState = state is GiftCreationFormState
            ? state
            : const GiftCreationFormState();
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
                        _buildTitle(context),
                        const SizedBox(height: AppSpacing.l),

                        // ── Recipient Number ──────────────────────────────
                        PhoneInputField(
                          label: AppStrings.recipientNoLabel,
                          phoneController: _phoneController,
                          countryCode: formState.countryCode,
                          hintText: AppStrings.phoneNumberPlaceholder,
                          onPhoneChanged: (val) {
                            context.read<GiftCreationBloc>().add(
                              RecipientPhoneChanged(val),
                            );
                          },
                          suffixIcon: _buildSearchSuffix(context, formState),
                        ),

                        // ── Recipient Card ────────────────────────────────
                        if (formState.isLookingUpRecipient) ...[
                          const SizedBox(height: AppSpacing.s),
                          const _RecipientLoadingShimmer(),
                        ] else if (formState.recipient != null) ...[
                          const SizedBox(height: AppSpacing.s),
                          RecipientCard(recipient: formState.recipient!),
                        ],

                        const SizedBox(height: AppSpacing.l),

                        // ── Amount ────────────────────────────────────────
                        _SectionLabel(label: AppStrings.enterAmountLabel),
                        const SizedBox(height: 8),
                        AppTextField(
                          hintText: AppStrings.amountHint,
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 14, right: 8),
                            child: Text(
                              '\$',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightTextHeading,
                              ),
                            ),
                          ),
                          onChanged: (val) {
                            final parsed = double.tryParse(val);
                            if (parsed != null) {
                              context.read<GiftCreationBloc>().add(
                                AmountChanged(parsed),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: AppSpacing.m),

                        // ── Quick Amount Chips ────────────────────────────
                        QuickAmountSelector(
                          selectedAmount: formState.amount,
                          onAmountSelected: (amount) {
                            _amountController.text = amount.toInt().toString();
                            context.read<GiftCreationBloc>().add(
                              QuickAmountSelected(amount),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.l),

                        // ── Options ───────────────────────────────────────
                        GiftOptionCheckbox(
                          label: AppStrings.hideAmountLabel,
                          value: formState.hideAmount,
                          onChanged: (val) => context
                              .read<GiftCreationBloc>()
                              .add(HideAmountToggled(val)),
                        ),
                        const SizedBox(height: AppSpacing.m),
                        GiftOptionCheckbox(
                          label: AppStrings.stayAnonymousLabel,
                          value: formState.stayAnonymous,
                          onChanged: (val) => context
                              .read<GiftCreationBloc>()
                              .add(StayAnonymousToggled(val)),
                        ),
                        const SizedBox(height: AppSpacing.l),

                        // ── Unlock Date & Time ────────────────────────────
                        _SectionLabel(label: AppStrings.selectUnlockDateLabel),
                        const SizedBox(height: 8),
                        DateTimePickerField(
                          labelText: '',
                          hintText: AppStrings.datePlaceholder,
                          value: formState.unlockDate != null
                              ? _formatDate(formState.unlockDate!)
                              : null,
                          trailingIcon: Icons.calendar_today_outlined,
                          onTap: () => _pickDate(context),
                        ),
                        const SizedBox(height: AppSpacing.s),
                        DateTimePickerField(
                          labelText: '',
                          hintText: AppStrings.timePlaceholder,
                          value: formState.unlockTime,
                          trailingIcon: Icons.access_time_outlined,
                          onTap: () => _pickTime(context),
                        ),
                        const SizedBox(height: AppSpacing.l),

                        // ── Message ───────────────────────────────────────
                        _SectionLabel(label: AppStrings.messageLabel),
                        const SizedBox(height: 8),
                        AppTextField(
                          hintText: AppStrings.messagePlaceholder,
                          controller: _messageController,
                          onChanged: (val) => context
                              .read<GiftCreationBloc>()
                              .add(MessageChanged(val)),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),

                // ── Continue Button (sticky footer) ───────────────────────
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
                    text: AppStrings.continueButton,
                    isLoading: isLoading,
                    onPressed: () {
                      context.read<GiftCreationBloc>().add(
                        const GiftSubmitted(),
                      );
                    },
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
          content: Text('Gift sent! Code: ${state.giftCode}'),
          backgroundColor: AppColors.success,
        ),
      );
      // TODO: Navigate to success screen, e.g. context.go('/gift-success')
    } else if (state is GiftCreationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildSearchSuffix(BuildContext context, GiftCreationFormState form) {
    if (form.isLookingUpRecipient) {
      return const Padding(
        padding: EdgeInsets.all(14),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      );
    }
    return IconButton(
      icon: const Icon(
        Icons.autorenew_outlined,
        color: AppColors.primary,
        size: 22,
      ),
      onPressed: () {
        final phone = _phoneController.text.trim();
        if (phone.isNotEmpty) {
          context.read<GiftCreationBloc>().add(
            RecipientLookupRequested(
              countryCode: form.countryCode,
              phone: phone,
            ),
          );
        }
      },
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      context.read<GiftCreationBloc>().add(UnlockDateSelected(picked));
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      final formatted = picked.format(context);
      context.read<GiftCreationBloc>().add(UnlockTimeSelected(formatted));
    }
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year;
    return '$d.$m.$y';
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.getBackgroundColor(context),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Dashboard',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextHeading,
        ),
      ),
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
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.lightTextHeading),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.sendAGiftTitle,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.sendAGiftSubtitle,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.getBodyTextColor(context).withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

/// Subtle label above a form section
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.getBodyTextColor(context).withOpacity(0.6),
      ),
    );
  }
}

/// Placeholder shimmer while looking up a recipient
class _RecipientLoadingShimmer extends StatelessWidget {
  const _RecipientLoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
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
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.lightInactiveBorder,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.m),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.lightInactiveBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.lightInactiveBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
