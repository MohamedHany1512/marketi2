class PaymobPaymentKeyResponse {
  final String token;

  PaymobPaymentKeyResponse({required this.token});

  factory PaymobPaymentKeyResponse.fromJson(Map<String, dynamic> json) {
    return PaymobPaymentKeyResponse(token: json['token'] ?? '');
  }
}