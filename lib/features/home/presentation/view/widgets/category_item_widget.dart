import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/category_model.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryItemWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: ClipOval(
            child: category.image != null
                ? Image.network(
                    category.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(Icons.category),
                  )
                : const Icon(Icons.category),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          category.name ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
