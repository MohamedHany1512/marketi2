import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/common/function.dart';
import 'package:marketi/features/auth/sign_up/presentation/view/widgets/custom_sign_up_text_form_field.dart';
import 'package:marketi/features/auth/sign_up/presentation/view/widgets/register_divider.dart';
import 'package:marketi/features/auth/sign_up/presentation/view/widgets/submit_button.dart';
import 'package:marketi/features/auth/sign_up/presentation/view_model/sign_up_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.state,
    required this.nameController,

    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onSubmit,
    required this.usernameController,
  });

  final SignUpState state;
  final TextEditingController nameController;

  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController usernameController;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  final VoidCallback onSubmit;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                const Spacer(),
              ],
            ),

            SizedBox(height: 8.h),

            SizedBox(height: 12.h),
            Image.asset(
              'assets/images/Logo_Splash_Screen_android12.png',
              width: 105.w,
              height: 75.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8.h),

            CustomSignUpTextFormField(
              label: 'Your Name',
              controller: widget.nameController,
              hintText: 'Full Name',
              icon: Icons.person_outline,
              validator: nameValidator,
            ),
            CustomSignUpTextFormField(
              label: 'Username',
              controller: widget.usernameController,
              hintText: 'Username',
              icon: Icons.person_outline,
              validator: userValidator,
            ),
            SizedBox(height: 4.h),

            CustomSignUpTextFormField(
              label: 'Phone Number',
              controller: widget.phoneController,
              hintText: '+20 1501142409',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: phoneValidator,
            ),

            CustomSignUpTextFormField(
              label: 'Email',
              controller: widget.emailController,
              hintText: 'You@gmail.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
            CustomSignUpTextFormField(
              label: 'Password',
              controller: widget.passwordController,
              hintText: '••••••••••••',
              icon: Icons.lock_outline,
              obscureText: state.obscurePassword,
              suffixIcon: IconButton(
                onPressed: widget.onTogglePassword,
                icon: Icon(
                  state.obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
              validator: passwordValidator,
            ),
            CustomSignUpTextFormField(
              label: 'Confirm Password',
              controller: widget.confirmPasswordController,
              hintText: '••••••••••••',
              icon: Icons.lock_outline,
              obscureText: state.obscureConfirmPassword,
              suffixIcon: IconButton(
                onPressed: widget.onToggleConfirmPassword,
                icon: Icon(
                  state.obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm password';
                }
                if (value != widget.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            SizedBox(height: 10.h),
            SubmitButton(
              isLoading: state.isLoading,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.onSubmit();
                }
              },
            ),
            SizedBox(height: 16.h),
            const RegisterDivider(),
          ],
        ),
      ),
    );
  }
}
