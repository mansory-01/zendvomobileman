import 'package:equatable/equatable.dart';

abstract class GiftCreationState extends Equatable {
  const GiftCreationState();

  @override
  List<Object?> get props => [];
}

class GiftCreationInitial extends GiftCreationState {}

class GiftCreationStepOne extends GiftCreationState {}

class GiftCreationStepTwo extends GiftCreationState {
  final String recipientPhone;
  const GiftCreationStepTwo(this.recipientPhone);

  @override
  List<Object?> get props => [recipientPhone];
}

class GiftCreationStepThree extends GiftCreationState {
  final String recipientPhone;
  final double amount;
  final DateTime unlockDate;
  const GiftCreationStepThree(
    this.recipientPhone,
    this.amount,
    this.unlockDate,
  );

  @override
  List<Object?> get props => [recipientPhone, amount, unlockDate];
}

class GiftCreationSuccess extends GiftCreationState {
  final String giftCode;
  const GiftCreationSuccess(this.giftCode);

  @override
  List<Object?> get props => [giftCode];
}

class GiftCreationError extends GiftCreationState {
  final String message;
  const GiftCreationError(this.message);

  @override
  List<Object?> get props => [message];
}
