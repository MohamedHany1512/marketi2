class PaymobAuthResponse {
  final String token;

  PaymobAuthResponse({required this.token});

  factory PaymobAuthResponse.fromJson(Map<String, dynamic> json) {
    return PaymobAuthResponse(token: json['token'] ?? '');
  }
}