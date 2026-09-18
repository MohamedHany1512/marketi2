// lib/features/checkout/data/repos/checkout_repo.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/end_points.dart';

class CheckoutRepo {
  final ApiConsumer apiConsumer;

  CheckoutRepo({required this.apiConsumer});

  // 1. Authenticate with Paymob
  Future<Either<ErrorModel, String>> getAuthToken(String apiKey) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.paymobAuthToken,
        data: {'api_key': apiKey},
        // إلغاء الـ Authorization Header الخاص بتطبيقك لهذا الطلب
        options: Options(
          headers: {'Authorization': null},
        ),
      );
      // التأكد من قراءة مفتاح 'token' من استجابة Paymob
      final String token = response['token'];
      return Right(token);
    } catch (e) {
      return Left(ErrorModel(errorMessage: e.toString(), status: 500));
    }
  }

  // 2. Register Order
  Future<Either<ErrorModel, int>> createOrder({
    required String authToken,
    required String amountCents,
    required List items,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.paymobOrderRegistration,
        data: {
          'auth_token': authToken, // توكن Paymob الناتج من الخطوة الأولى
          'delivery_needed': 'false',
          'amount_cents': amountCents,
          'currency': 'EGP',
          'items': items,
        },
        options: Options(
          headers: {'Authorization': null},
        ),
      );
      final int orderId = response['id'];
      return Right(orderId);
    } catch (e) {
      return Left(ErrorModel(errorMessage: e.toString(), status: 500));
    }
  }

  // 3. Get Payment Key
  Future<Either<ErrorModel, String>> getPaymentKey({
    required String authToken,
    required String orderId,
    required String amountCents,
    required String integrationId,
    required Map<String, dynamic> billingData,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.paymobPaymentKey,
        data: {
          'auth_token': authToken,
          'amount_cents': amountCents,
          'expiration': 3600,
          'order_id': orderId,
          'billing_data': billingData,
          'currency': 'EGP',
          'integration_id': integrationId,
        },
        options: Options(
          headers: {'Authorization': null},
        ),
      );
      final String paymentToken = response['token'];
      return Right(paymentToken);
    } catch (e) {
      return Left(ErrorModel(errorMessage: e.toString(), status: 500));
    }
  }
}