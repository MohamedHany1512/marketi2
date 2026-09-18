import 'package:marketi/core/network/api/api_consumer.dart';
import 'package:marketi/core/network/api/end_points.dart';

import '../models/sign_up_request_model.dart';
import '../models/sign_up_response_model.dart';

class SignUpRepo {
  final ApiConsumer apiConsumer;

  SignUpRepo({
    required this.apiConsumer,
  });

  Future<SignUpResponseModel> signUp(
    SignUpRequestModel request,
  ) async {
    final response = await apiConsumer.post(
      EndPoint.signUp,
      data: request.toJson(),
    );

    return SignUpResponseModel.fromJson(
      Map<String, dynamic>.from(response),
    );
  }
}