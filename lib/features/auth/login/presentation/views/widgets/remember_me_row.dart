import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMeRow extends StatelessWidget {
  const RememberMeRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: const Color(0xFF3F7FFF),
          onChanged: (_) => onChanged(),
        ),
        Text('Remember Me', style: TextStyle(fontSize: 14.sp)),
        const Spacer(),
        TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
      ],
    );
  }
}
