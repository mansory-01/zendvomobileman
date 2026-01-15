import 'package:equatable/equatable.dart';

abstract class GiftCreationEvent extends Equatable {
  const GiftCreationEvent();

  @override
  List<Object?> get props => [];
}

class StepOneCompleted extends GiftCreationEvent {
  final String recipientPhone;
  const StepOneCompleted(this.recipientPhone);

  @override
  List<Object?> get props => [recipientPhone];
}

class StepTwoCompleted extends GiftCreationEvent {
  final double amount;
  final DateTime unlockDate;
  final String message;
  const StepTwoCompleted(this.amount, this.unlockDate, this.message);

  @override
  List<Object?> get props => [amount, unlockDate, message];
}

class PaymentProcessed extends GiftCreationEvent {}
