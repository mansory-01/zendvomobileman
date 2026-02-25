import 'package:equatable/equatable.dart';
import 'package:zendvo/features/gift_creation/domain/models/gift_creation_model.dart';
import 'package:zendvo/features/gift_creation/domain/models/recipient_model.dart';

abstract class GiftCreationState extends Equatable {
  const GiftCreationState();

  @override
  List<Object?> get props => [];
}

/// Default state — form is idle
class GiftCreationInitial extends GiftCreationState {
  const GiftCreationInitial();
}

/// Form state carrying all live form values
class GiftCreationFormState extends GiftCreationState {
  final String phone;
  final String countryCode;
  final RecipientModel? recipient;
  final double? amount;
  final bool hideAmount;
  final bool stayAnonymous;
  final DateTime? unlockDate;
  final String? unlockTime;
  final String message;
  final bool isLookingUpRecipient;

  const GiftCreationFormState({
    this.phone = '',
    this.countryCode = '+234',
    this.recipient,
    this.amount,
    this.hideAmount = false,
    this.stayAnonymous = false,
    this.unlockDate,
    this.unlockTime,
    this.message = '',
    this.isLookingUpRecipient = false,
  });

  GiftCreationFormState copyWith({
    String? phone,
    String? countryCode,
    RecipientModel? recipient,
    double? amount,
    bool? hideAmount,
    bool? stayAnonymous,
    DateTime? unlockDate,
    String? unlockTime,
    String? message,
    bool? isLookingUpRecipient,
  }) {
    return GiftCreationFormState(
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      hideAmount: hideAmount ?? this.hideAmount,
      stayAnonymous: stayAnonymous ?? this.stayAnonymous,
      unlockDate: unlockDate ?? this.unlockDate,
      unlockTime: unlockTime ?? this.unlockTime,
      message: message ?? this.message,
      isLookingUpRecipient: isLookingUpRecipient ?? this.isLookingUpRecipient,
    );
  }

  /// Convenience: build the API payload model from the current form state
  GiftCreationModel toModel() {
    return GiftCreationModel(
      recipientPhone: phone,
      countryCode: countryCode,
      amount: amount ?? 0,
      hideAmount: hideAmount,
      stayAnonymous: stayAnonymous,
      unlockDate: unlockDate,
      unlockTime: unlockTime,
      message: message.isEmpty ? null : message,
    );
  }

  bool get isFormValid =>
      phone.isNotEmpty && recipient != null && (amount ?? 0) > 0;

  @override
  List<Object?> get props => [
    phone,
    countryCode,
    recipient,
    amount,
    hideAmount,
    stayAnonymous,
    unlockDate,
    unlockTime,
    message,
    isLookingUpRecipient,
  ];
}

/// Gift submitted and processing
class GiftCreationLoading extends GiftCreationState {
  const GiftCreationLoading();
}

/// Gift sent successfully
class GiftCreationSuccess extends GiftCreationState {
  final String giftCode;
  const GiftCreationSuccess({required this.giftCode});

  @override
  List<Object?> get props => [giftCode];
}

/// An error occurred
class GiftCreationError extends GiftCreationState {
  final String message;
  const GiftCreationError({required this.message});

  @override
  List<Object?> get props => [message];
}
