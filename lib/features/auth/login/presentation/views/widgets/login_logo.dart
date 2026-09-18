import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Logo_Splash_Screen_android12.png',
      width: 130.w,
      height: 130.h,
      fit: BoxFit.contain,
    );
  }
}
