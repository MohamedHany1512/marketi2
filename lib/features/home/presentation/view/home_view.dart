import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/common/custom_app_bar.dart';
import 'package:marketi/core/routing/app_routes.dart';

import 'package:marketi/features/home/presentation/view/widgets/nav_bar.dart';

import '../view_model/products_cubit.dart';
import '../view_model/products_states.dart';
import 'widgets/brand_item_widget.dart';
import 'widgets/category_item_widget.dart';
import 'widgets/home_section_header_widget.dart';
import 'widgets/product_card_widget.dart';
import 'widgets/search_field_widget.dart';
import 'widgets/special_deal_banner_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state.paginationErrorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.paginationErrorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage!),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProductsCubit>().fetchHomeData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchFieldWidget(),
                SizedBox(height: 16.h),
                const SpecialDealBannerWidget(),
                SizedBox(height: 20.h),
                HomeSectionHeaderWidget(
                  title: 'Popular Product',
                  onViewAllPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.products,
                      arguments: {
                        'title': 'Popular Products',
                        'products': state.products,
                      },
                    );
                  },
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 210.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products.take(2).length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 160.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetails,
                            arguments: state.products[index],
                          );
                        },
                        child: ProductCardWidget(
                          product: state.products[index],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                HomeSectionHeaderWidget(
                  title: 'Category',
                  onViewAllPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.categories,
                      arguments: state.categories,
                    );
                  },
                ),
                SizedBox(height: 12.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                  ),
                  itemCount: state.categories.take(6).length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.categoryProducts,
                        arguments: state.categories[index].name,
                      );
                    },
                    child: CategoryItemWidget(
                      category: state.categories[index],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                HomeSectionHeaderWidget(
                  title: 'Brands',
                  onViewAllPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.brands,
                      arguments: state.brands,
                    );
                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.brands.take(3).length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.brandProducts,
                          arguments: state.brands[index].name,
                        );
                      },
                      child: BrandItemWidget(brand: state.brands[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
