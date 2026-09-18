class PaymobOrderResponse {
  final int id;

  PaymobOrderResponse({required this.id});

  factory PaymobOrderResponse.fromJson(Map<String, dynamic> json) {
    return PaymobOrderResponse(id: json['id'] ?? 0);
  }
}