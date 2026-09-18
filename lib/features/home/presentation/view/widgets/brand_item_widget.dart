import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/brand_model.dart';

class BrandItemWidget extends StatelessWidget {
  final BrandModel brand;

  const BrandItemWidget({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          if (brand.emoji != null)
            Text(brand.emoji!, style: TextStyle(fontSize: 18.sp)),
          if (brand.emoji != null) SizedBox(width: 8.w),
          Text(
            brand.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
