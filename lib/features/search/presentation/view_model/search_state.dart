import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadingMoreState extends SearchState {}

class SearchProductsSuccessState extends SearchState {
  final List<ProductModel> products;
  final bool hasMore;

  SearchProductsSuccessState({
    required this.products,
    required this.hasMore,
  });
}

class SearchCategoriesSuccessState extends SearchState {
  final List<CategoryModel> categories;

  SearchCategoriesSuccessState(this.categories);
}

class SearchBrandsSuccessState extends SearchState {
  final List<BrandModel> brands;

  SearchBrandsSuccessState(this.brands);
}

class SearchEmptyState extends SearchState {
  final String query;

  SearchEmptyState(this.query);
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);
}

class SearchFilterChangedState extends SearchState {
  final SearchFilter filter;

  SearchFilterChangedState(this.filter);
}

enum SearchFilter {
  product,
  category,
  brand,
}