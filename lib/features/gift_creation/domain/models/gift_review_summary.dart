import 'package:equatable/equatable.dart';

/// Immutable summary of a gift used to populate the Review screen.
/// Built from [GiftCreationFormState] before navigating to review.
class GiftReviewSummary extends Equatable {
  final String recipientName;
  final String recipientPhone;
  final double amount;
  final double processingFee;
  final bool hideAmount;
  final bool stayAnonymous;
  final String unlockDateTime;
  final String? message;

  const GiftReviewSummary({
    required this.recipientName,
    required this.recipientPhone,
    required this.amount,
    required this.processingFee,
    required this.unlockDateTime,
    this.hideAmount = false,
    this.stayAnonymous = false,
    this.message,
  });

  double get totalAmount => amount + processingFee;

  Map<String, dynamic> toJson() => {
    'recipient_name': recipientName,
    'recipient_phone': recipientPhone,
    'amount': amount,
    'processing_fee': processingFee,
    'total_amount': totalAmount,
    'hide_amount': hideAmount,
    'stay_anonymous': stayAnonymous,
    'unlock_date_time': unlockDateTime,
    'message': message,
  };

  @override
  List<Object?> get props => [
    recipientName,
    recipientPhone,
    amount,
    processingFee,
    hideAmount,
    stayAnonymous,
    unlockDateTime,
    message,
  ];
}
