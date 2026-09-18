import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,

      borderRadius: BorderRadius.circular(50.r),

      child: Container(
        width: 32.w,
        height: 32.h,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          border: Border.all(color: const Color(0xFFD5E2FF)),
        ),

        child: Icon(Icons.arrow_back_ios_new, size: 14.sp, color: Colors.black),
      ),
    );
  }
}
