import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

import '../../data/models/category_model.dart';

class ProductsState {
  final List<CategoryModel> categories;
  final List<BrandModel> brands;
  final List<ProductModel> products;

  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final String? paginationErrorMessage;

  final int currentPage;
  final bool hasMore;

  const ProductsState({
    this.categories = const [],
    this.brands = const [],
    this.products = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.paginationErrorMessage,
    this.currentPage = 1,
    this.hasMore = true,
  });

  ProductsState copyWith({
    List<CategoryModel>? categories,
    List<BrandModel>? brands,
    List<ProductModel>? products,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    bool? hasMore,
  }) {
    return ProductsState(
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
      paginationErrorMessage: paginationErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
