import 'package:equatable/equatable.dart';

class RecipientModel extends Equatable {
  final String phoneNumber;
  final String displayName;
  final String currency;
  final String? avatarUrl;

  const RecipientModel({
    required this.phoneNumber,
    required this.displayName,
    required this.currency,
    this.avatarUrl,
  });

  factory RecipientModel.fromJson(Map<String, dynamic> json) {
    return RecipientModel(
      phoneNumber: json['phone_number'] as String,
      displayName: json['display_name'] as String,
      currency: json['currency'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'display_name': displayName,
      'currency': currency,
      'avatar_url': avatarUrl,
    };
  }

  @override
  List<Object?> get props => [phoneNumber, displayName, currency, avatarUrl];
}
