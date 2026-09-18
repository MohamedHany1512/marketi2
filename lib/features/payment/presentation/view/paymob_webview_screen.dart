import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/network/api/end_points.dart';

class PaymobWebViewScreen extends StatefulWidget {
  final String paymentToken;
  final String iframeId;

  const PaymobWebViewScreen({
    super.key,
    required this.paymentToken,
    required this.iframeId,
  });

  @override
  State<PaymobWebViewScreen> createState() => _PaymobWebViewScreenState();
}

class _PaymobWebViewScreenState extends State<PaymobWebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    final url = '${EndPoint.paymobIframeUrl}/${widget.iframeId}?payment_token=${widget.paymentToken}';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob Payment'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}