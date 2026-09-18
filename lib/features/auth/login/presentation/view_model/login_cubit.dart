import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketi/core/helper/cache_helper.dart';
import 'package:marketi/core/network/api/end_points.dart';
import 'package:marketi/features/auth/login/data/repo/login_repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository repository;

  LoginCubit({required this.repository}) : super(const LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleRememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      emit(
        state.copyWith(
          isFailure: true,
          isSuccess: false,
          errorMessage: 'Please enter your email',
        ),
      );

      return;
    }

    if (password.isEmpty) {
      emit(
        state.copyWith(
          isFailure: true,
          isSuccess: false,
          errorMessage: 'Please enter your password',
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        isFailure: false,
        errorMessage: null,
      ),
    );

    try {
      final result = await repository.login(
        email: email.trim(),
        password: password,
      );

      await CacheHelper().saveData(key: ApiKey.token, value: result.token);

      await CacheHelper().saveData(key: ApiKey.name, value: result.user.name);

      await CacheHelper().saveData(key: ApiKey.email, value: result.user.email);

      await CacheHelper().saveData(key: ApiKey.phone, value: result.user.phone);
      await CacheHelper().saveData(key: ApiKey.image, value: result.user.image);



      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          loginModel: result,
        ),
      );
      
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          isFailure: true,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
