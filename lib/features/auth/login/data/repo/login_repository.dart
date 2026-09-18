import 'package:marketi/core/network/api/api_consumer.dart';
import 'package:marketi/core/network/api/end_points.dart';
import 'package:marketi/features/auth/login/data/models/login_model.dart';

class LoginRepository {
  final ApiConsumer apiConsumer;

  LoginRepository({
    required this.apiConsumer,
  });

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      EndPoint.signIn,
      data: {
        ApiKey.email: email,
        ApiKey.password: password,
      },
    );

    return LoginModel.fromJson(
      response as Map<String, dynamic>,
    );
  }
}