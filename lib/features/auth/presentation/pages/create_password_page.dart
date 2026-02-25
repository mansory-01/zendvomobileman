import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zendvo/core/constants/app_colors.dart';
import 'package:zendvo/core/constants/app_spacing.dart';
import 'package:zendvo/core/constants/app_strings.dart';
import 'package:zendvo/core/widgets/app_button.dart';
import 'package:zendvo/core/widgets/app_text_field.dart';
import 'package:zendvo/features/auth/presentation/bloc/create_password/create_password_bloc.dart';
import 'package:zendvo/features/auth/presentation/bloc/create_password/create_password_event.dart';
import 'package:zendvo/features/auth/presentation/bloc/create_password/create_password_state.dart';

/// Screen where user enters and confirms their new password.
class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePasswordBloc(),
      child: const CreatePasswordView(),
    );
  }
}

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({super.key});

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
      listener: _handleStateChanges,
      builder: (context, state) {
        final isLoading = state is CreatePasswordLoading;
        final isValid = state is CreatePasswordFormState && state.isFormValid;

        return Scaffold(
          backgroundColor: AppColors.getBackgroundColor(context),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLogo(),
                        const SizedBox(height: AppSpacing.xxl),
                        _buildHeader(context),
                        const SizedBox(height: AppSpacing.xl),

                        // New Password Field
                        AppTextField(
                          controller: _newPasswordController,
                          label: AppStrings.enterNewPasswordLabel,
                          isPassword: true,
                          onChanged: (value) => context
                              .read<CreatePasswordBloc>()
                              .add(NewPasswordChanged(value)),
                        ),

                        const SizedBox(height: AppSpacing.s),
                        // Password hint
                        Text(
                          AppStrings.passwordHint,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.getInactiveBorderColor(context),
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // Confirm Password Field
                        AppTextField(
                          controller: _confirmPasswordController,
                          label: AppStrings.confirmPasswordLabel,
                          isPassword: true,
                          onChanged: (value) => context
                              .read<CreatePasswordBloc>()
                              .add(ConfirmPasswordChanged(value)),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Area: Button + Footer Links
                Padding(
                  padding: AppSpacing.screenPadding.copyWith(
                    bottom: AppSpacing.l,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        text: AppStrings.createNewPasswordButton,
                        isLoading: isLoading,
                        onPressed: (!isValid || isLoading)
                            ? null
                            : () => context.read<CreatePasswordBloc>().add(
                                const CreatePasswordSubmitted(),
                              ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      _buildFooterLinks(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleStateChanges(BuildContext context, CreatePasswordState state) {
    if (state is CreatePasswordSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      // TODO: Navigate to Login or Dashboard
    } else if (state is CreatePasswordError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.vignette, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 8),
        const Text(
          'Zendvo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors
                .primary, // Using primary since no specific text logo token was given
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.createNewPasswordTitle,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.getHeadingTextColor(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.createNewPasswordSubtitle,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: AppColors.getBodyTextColor(context).withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    final style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.getInactiveBorderColor(context),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // TODO: Open Help Dialog
          },
          child: Text(AppStrings.help, style: style),
        ),
        _buildDivider(context),
        GestureDetector(
          onTap: () {
            // TODO: Open Terms
          },
          child: Text(AppStrings.terms, style: style),
        ),
        _buildDivider(context),
        GestureDetector(
          onTap: () {
            // TODO: Open Privacy Policy
          },
          child: Text(AppStrings.privacy, style: style),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Text(
        '|',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.getInactiveBorderColor(context),
        ),
      ),
    );
  }
}
