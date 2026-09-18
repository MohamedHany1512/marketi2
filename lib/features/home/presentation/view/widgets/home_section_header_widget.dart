import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onViewAllPressed;

  const HomeSectionHeaderWidget({
    super.key,
    required this.title,
    required this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onViewAllPressed,
          child: Text(
            'View all',
            style: TextStyle(color: Colors.blue, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
