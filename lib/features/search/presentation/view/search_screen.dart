import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/common/debouncer.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';

import 'package:marketi/features/home/presentation/view/widgets/brand_item_widget.dart';
import 'package:marketi/features/home/presentation/view/widgets/category_item_widget.dart';
import 'package:marketi/features/home/presentation/view/widgets/product_card_widget.dart';

import '../view_model/search_cubit.dart';
import '../view_model/search_state.dart';

class SearchScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  final List<BrandModel> brands;

  const SearchScreen({
    super.key,
    required this.categories,
    required this.brands,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Debouncer _debouncer = Debouncer();

  final TextEditingController _controller = TextEditingController();

  late final SearchCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<SearchCubit>();

    _cubit.setData(
      categories: widget.categories.cast(),
      brands: widget.brands.cast(),
    );
  }

  @override
  void dispose() {
    _debouncer.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          _buildSearchField(),

          SizedBox(height: 8.h),

          _buildFilters(),

          SizedBox(height: 8.h),

          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SearchErrorState) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(state.error, textAlign: TextAlign.center),
                    ),
                  );
                }

                if (state is SearchEmptyState) {
                  return Center(child: Text('No results for "${state.query}"'));
                }

                if (state is SearchProductsSuccessState) {
                  return _buildProducts(state);
                }

                if (state is SearchCategoriesSuccessState) {
                  return _buildCategories(state.categories);
                }

                if (state is SearchBrandsSuccessState) {
                  return _buildBrands(state.brands);
                }

                return const Center(child: Text('Start searching now'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search here...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _controller.clear();
                    _cubit.search('');
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        onChanged: (value) {
          setState(() {});

          _debouncer.run(() {
            _cubit.search(value);
          });
        },
        onSubmitted: (value) {
          _cubit.search(value);
        },
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 45.h,
      child: BlocBuilder<SearchCubit, SearchState>(
        buildWhen: (previous, current) {
          return current is SearchFilterChangedState ||
              current is SearchInitialState;
        },
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            children: SearchFilter.values.map((filter) {
              final selected = _cubit.currentFilter == filter;

              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ChoiceChip(
                  label: Text(_getFilterLabel(filter)),
                  selected: selected,
                  onSelected: (_) {
                    _cubit.setFilter(filter);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildProducts(SearchProductsSuccessState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 300) {
          _cubit.loadMoreProducts();
        }

        return false;
      },
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.60,
        ),
        itemCount: state.products.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.products.length) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final product = state.products[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.productDetails,
                arguments: product,
              );
            },
            child: ProductCardWidget(product: product),
          );
        },
      ),
    );
  }

  Widget _buildCategories(List<CategoryModel> categories) {
    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.categoryProducts,
              arguments: category.name,
            );
          },
          child: CategoryItemWidget(category: category),
        );
      },
    );
  }

  Widget _buildBrands(List<BrandModel> brands) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: brands.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final brand = brands[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.brandProducts,
              arguments: brand.name,
            );
          },
          child: BrandItemWidget(brand: brand),
        );
      },
    );
  }

  String _getFilterLabel(SearchFilter filter) {
    switch (filter) {
      case SearchFilter.product:
        return 'Products';

      case SearchFilter.category:
        return 'Categories';

      case SearchFilter.brand:
        return 'Brands';
    }
  }
}
