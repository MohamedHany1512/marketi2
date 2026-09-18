import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/core/services/services_locator.dart';
import 'package:marketi/features/home/presentation/view/widgets/product_card_widget.dart';
import 'package:marketi/features/home/presentation/view_model/products_cubit.dart';
import 'package:marketi/features/home/presentation/view_model/products_states.dart';

class BrandProductsView extends StatelessWidget {
  final String brandName;

  const BrandProductsView({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsCubit>()..getProductsByBrand(brandName),
      child: Scaffold(
        appBar: AppBar(title: Text(brandName)),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }
            if (state.products.isEmpty) {
              return const Center(
                child: Text('No products found for this brand'),
              );
            }
            return GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.productDetails,
                      arguments: product,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.productDetails,
                        arguments: product,
                      );
                    },
                    child: ProductCardWidget(product: product),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
