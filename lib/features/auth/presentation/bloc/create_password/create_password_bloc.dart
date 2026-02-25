import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_password_event.dart';
import 'create_password_state.dart';

class CreatePasswordBloc
    extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  CreatePasswordBloc() : super(const CreatePasswordFormState()) {
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<CreatePasswordSubmitted>(_onSubmit);
  }

  CreatePasswordFormState get _form => state is CreatePasswordFormState
      ? state as CreatePasswordFormState
      : const CreatePasswordFormState();

  void _onNewPasswordChanged(
    NewPasswordChanged event,
    Emitter<CreatePasswordState> emit,
  ) {
    emit(_form.copyWith(newPassword: event.password));
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<CreatePasswordState> emit,
  ) {
    emit(_form.copyWith(confirmPassword: event.password));
  }

  Future<void> _onSubmit(
    CreatePasswordSubmitted event,
    Emitter<CreatePasswordState> emit,
  ) async {
    if (!_form.isFormValid) return;

    emit(const CreatePasswordLoading());

    // TODO: Replace with actual repository call to update the password
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success
    emit(const CreatePasswordSuccess());
  }
}
