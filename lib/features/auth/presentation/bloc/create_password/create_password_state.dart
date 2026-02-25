import 'package:equatable/equatable.dart';

abstract class CreatePasswordState extends Equatable {
  const CreatePasswordState();

  @override
  List<Object?> get props => [];
}

class CreatePasswordFormState extends CreatePasswordState {
  final String newPassword;
  final String confirmPassword;

  const CreatePasswordFormState({
    this.newPassword = '',
    this.confirmPassword = '',
  });

  CreatePasswordFormState copyWith({
    String? newPassword,
    String? confirmPassword,
  }) {
    return CreatePasswordFormState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  // Basic validation: Passwords match, are not empty, and are at least 8 chars.
  // The UI also shows requirements but this is the minimum to enable the button.
  bool get isFormValid =>
      newPassword.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      newPassword.length >= 8 &&
      newPassword == confirmPassword;

  @override
  List<Object?> get props => [newPassword, confirmPassword];
}

class CreatePasswordLoading extends CreatePasswordState {
  const CreatePasswordLoading();
}

class CreatePasswordSuccess extends CreatePasswordState {
  const CreatePasswordSuccess();
}

class CreatePasswordError extends CreatePasswordState {
  final String message;

  const CreatePasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}
