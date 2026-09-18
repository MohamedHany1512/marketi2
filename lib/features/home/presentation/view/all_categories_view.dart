import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/core/themes/app_theme.dart';

import '../../data/models/category_model.dart';
import 'widgets/category_item_widget.dart';

class AllCategoriesView extends StatelessWidget {
  final List<CategoryModel> categories;

  const AllCategoriesView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: category.name == null
                ? null
                : () => Navigator.pushNamed(
                    context,
                    AppRoutes.categoryProducts,
                    arguments: category.name,
                  ),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.categoryProducts,
                arguments: category.name,
              ),
              child: CategoryItemWidget(category: category),
            ),
          );
        },
      ),
    );
  }
}
