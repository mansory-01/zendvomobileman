import 'package:equatable/equatable.dart';

abstract class CreatePasswordEvent extends Equatable {
  const CreatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class NewPasswordChanged extends CreatePasswordEvent {
  final String password;
  const NewPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends CreatePasswordEvent {
  final String password;
  const ConfirmPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class CreatePasswordSubmitted extends CreatePasswordEvent {
  const CreatePasswordSubmitted();
}
