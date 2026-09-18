import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/features/auth/login/presentation/views/widgets/login_form.dart';

import '../view_model/login_cubit.dart';
import '../view_model/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successfully')),
                );

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              }

              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Something went wrong'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return LoginForm(
                state: state,
                emailController: emailController,
                passwordController: passwordController,
                onTogglePassword: context
                    .read<LoginCubit>()
                    .togglePasswordVisibility,
                onToggleRememberMe: context.read<LoginCubit>().toggleRememberMe,
                onLogin: () {
                  context.read<LoginCubit>().login(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
