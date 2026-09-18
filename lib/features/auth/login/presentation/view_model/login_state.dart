import 'package:marketi/features/auth/login/data/models/login_model.dart';


class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  final String? errorMessage;

  final LoginModel? loginModel;

  final bool obscurePassword;
  final bool rememberMe;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage,
    this.loginModel,
    this.obscurePassword = true,
    this.rememberMe = true,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    LoginModel? loginModel,
    bool? obscurePassword,
    bool? rememberMe,
  }) {
    return LoginState(
      isLoading:
          isLoading ?? this.isLoading,

      isSuccess:
          isSuccess ?? this.isSuccess,

      isFailure:
          isFailure ?? this.isFailure,

      errorMessage:
          errorMessage ?? this.errorMessage,

      loginModel:
          loginModel ?? this.loginModel,

      obscurePassword:
          obscurePassword ??
              this.obscurePassword,

      rememberMe:
          rememberMe ?? this.rememberMe,
    );
  }
}