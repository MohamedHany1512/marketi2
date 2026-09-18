import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/core/themes/app_theme.dart';

import '../../data/models/brand_model.dart';
import 'widgets/brand_item_widget.dart';

class AllBrandsView extends StatelessWidget {
  final List<BrandModel> brands;

  const AllBrandsView({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Brands'),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: brands.length,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final brand = brands[index];
          return InkWell(
            onTap: brand.name == null
                ? null
                : () => Navigator.pushNamed(
                    context,
                    AppRoutes.brandProducts,
                    arguments: brand.name,
                  ),
            child: BrandItemWidget(brand: brand),
          );
        },
      ),
    );
  }
}
