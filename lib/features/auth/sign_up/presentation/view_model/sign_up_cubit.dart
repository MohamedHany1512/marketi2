import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/auth/sign_up/data/repo/sign_up_repo.dart';

import '../../data/models/sign_up_request_model.dart';

import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo repo;

  SignUpCubit({
    required this.repo,
  }) : super(const SignUpState());

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
        obscurePassword:
            !state.obscurePassword,
      ),
    );
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(
        obscureConfirmPassword:
            !state.obscureConfirmPassword,
      ),
    );
  }

 Future<void> signUp({
  required String name,
  required String username,
  required String phone,
  required String email,
  required String password,
  required String confirmPassword,
}) async {
  emit(
    state.copyWith(
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    ),
  );

  try {
    final request = SignUpRequestModel(
      name: name.trim(),
      username: username.trim(),
      phone: phone.trim(),
      email: email.trim(),
      password: password,
      confirmPassword: confirmPassword,
    );

    final response = await repo.signUp(request);

    emit(
      state.copyWith(
        isLoading: false,
        isSuccess: true,
        response: response,
      ),
    );
  } catch (e) {
    emit(
      state.copyWith(
        isLoading: false,
        isFailure: true,
        errorMessage: e.toString(),
      ),
    );
  }
}
}