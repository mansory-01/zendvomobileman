import 'package:equatable/equatable.dart';

class GiftCreationModel extends Equatable {
  final String recipientPhone;
  final String countryCode;
  final double amount;
  final bool hideAmount;
  final bool stayAnonymous;
  final DateTime? unlockDate;
  final String? unlockTime;
  final String? message;

  const GiftCreationModel({
    required this.recipientPhone,
    required this.countryCode,
    required this.amount,
    this.hideAmount = false,
    this.stayAnonymous = false,
    this.unlockDate,
    this.unlockTime,
    this.message,
  });

  GiftCreationModel copyWith({
    String? recipientPhone,
    String? countryCode,
    double? amount,
    bool? hideAmount,
    bool? stayAnonymous,
    DateTime? unlockDate,
    String? unlockTime,
    String? message,
  }) {
    return GiftCreationModel(
      recipientPhone: recipientPhone ?? this.recipientPhone,
      countryCode: countryCode ?? this.countryCode,
      amount: amount ?? this.amount,
      hideAmount: hideAmount ?? this.hideAmount,
      stayAnonymous: stayAnonymous ?? this.stayAnonymous,
      unlockDate: unlockDate ?? this.unlockDate,
      unlockTime: unlockTime ?? this.unlockTime,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient_phone': '$countryCode$recipientPhone',
      'amount': amount,
      'hide_amount': hideAmount,
      'stay_anonymous': stayAnonymous,
      'unlock_date': unlockDate?.toIso8601String(),
      'unlock_time': unlockTime,
      'message': message,
    };
  }

  @override
  List<Object?> get props => [
    recipientPhone,
    countryCode,
    amount,
    hideAmount,
    stayAnonymous,
    unlockDate,
    unlockTime,
    message,
  ];
}
