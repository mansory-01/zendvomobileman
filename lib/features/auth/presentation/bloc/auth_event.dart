import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class VerifyPhoneRequested extends AuthEvent {
  final String phoneNumber;
  const VerifyPhoneRequested(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOTPRequested extends AuthEvent {
  final String phoneNumber;
  final String otp;
  const VerifyOTPRequested(this.phoneNumber, this.otp);

  @override
  List<Object?> get props => [phoneNumber, otp];
}

class LogoutRequested extends AuthEvent {}
