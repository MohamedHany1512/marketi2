import '../../data/models/sign_up_response_model.dart';

class SignUpState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  final bool obscurePassword;
  final bool obscureConfirmPassword;

  final String? errorMessage;

  final SignUpResponseModel? response;

  const SignUpState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.errorMessage,
    this.response,
  });

  SignUpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
    SignUpResponseModel? response,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      obscurePassword:
          obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ??
              this.obscureConfirmPassword,
      errorMessage:
          errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }
}