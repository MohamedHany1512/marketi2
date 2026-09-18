import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/services/services_locator.dart';
import 'package:marketi/core/themes/app_colors.dart';
import 'package:marketi/features/auth/sign_up/presentation/view/widgets/sign_up_form.dart';

import '../view_model/sign_up_cubit.dart';
import '../view_model/sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();

    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.response?.message ?? 'Account created successfully',
                    ),
                  ),
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
              return SignUpForm(
                state: state,
                nameController: nameController,
                usernameController: usernameController,
                phoneController: phoneController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                onTogglePassword: context
                    .read<SignUpCubit>()
                    .togglePasswordVisibility,
                onToggleConfirmPassword: context
                    .read<SignUpCubit>()
                    .toggleConfirmPasswordVisibility,
                onSubmit: () {
                  context.read<SignUpCubit>().signUp(
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    confirmPassword: confirmPasswordController.text,
                    username: usernameController.text,
                  );
                  Navigator.pushNamed(context, '/login');
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

  


