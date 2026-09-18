import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/themes/app_theme.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
    foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
    elevation: 0,
    title: Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundImage: AssetImage('assets/images/Logo_Splash_Screen.png'),
        ),
        SizedBox(width: 8.w),
        const Text('Hi Youssef !'),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.blue),
          onPressed: () {},
        ),
      ],
    ),
  );
}
