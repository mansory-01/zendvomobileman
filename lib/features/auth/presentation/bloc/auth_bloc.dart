import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // TODO: Inject UseCases

  AuthBloc() : super(AuthInitial()) {
    on<VerifyPhoneRequested>(_onVerifyPhoneRequested);
    on<VerifyOTPRequested>(_onVerifyOTPRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onVerifyPhoneRequested(
    VerifyPhoneRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Call VerifyPhoneUseCase
    // await Future.delayed(const Duration(seconds: 1));
    emit(AuthCodeSent(event.phoneNumber));
  }

  Future<void> _onVerifyOTPRequested(
    VerifyOTPRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Call VerifyOTPUseCase
    // await Future.delayed(const Duration(seconds: 1));
    emit(const AuthAuthenticated('user_entity_placeholder'));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Call LogoutUseCase
    emit(AuthUnauthenticated());
  }
}
