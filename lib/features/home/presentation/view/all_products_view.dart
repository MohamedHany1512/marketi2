import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/themes/app_theme.dart';

import '../view_model/products_cubit.dart';
import '../view_model/products_states.dart';
import 'widgets/product_card_widget.dart';

class AllProductsView extends StatelessWidget {
  final String title;

  const AllProductsView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 200) {
                context.read<ProductsCubit>().loadMoreProducts();
              }
              return false;
            },
            child: GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: state.products.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.products.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/productDetails',
                      arguments: state.products[index],
                    );
                  },
                  child: ProductCardWidget(product: state.products[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
