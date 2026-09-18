import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

import 'package:marketi/features/search/data/repos/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(SearchInitialState());

  List<ProductModel> products = [];

  List<CategoryModel> allCategories = [];

  List<BrandModel> allBrands = [];

  String currentQuery = '';

  int _currentPage = 1;

  bool _hasMore = false;

  SearchFilter currentFilter = SearchFilter.product;

  void setData({
    required List<CategoryModel> categories,
    required List<BrandModel> brands,
  }) {
    allCategories = categories;
    allBrands = brands;
  }

  void setFilter(SearchFilter filter) {
    currentFilter = filter;

    emit(SearchFilterChangedState(filter));

    final query = currentQuery.trim();

    if (query.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    switch (filter) {
      case SearchFilter.product:
        searchProducts(
          query: query,
          page: 1,
        );
        break;

      case SearchFilter.category:
        _searchCategoriesLocally(query);
        break;

      case SearchFilter.brand:
        _searchBrandsLocally(query);
        break;
    }
  }

  void search(String query) {
    currentQuery = query.trim();

    if (currentQuery.isEmpty) {
      products = [];
      _currentPage = 1;
      _hasMore = false;

      emit(SearchInitialState());
      return;
    }

    switch (currentFilter) {
      case SearchFilter.product:
        searchProducts(
          query: currentQuery,
          page: 1,
        );
        break;

      case SearchFilter.category:
        _searchCategoriesLocally(currentQuery);
        break;

      case SearchFilter.brand:
        _searchBrandsLocally(currentQuery);
        break;
    }
  }

  Future<void> searchProducts({
    required String query,
    required int page,
  }) async {
    if (isClosed) return;

    if (page == 1) {
      emit(SearchLoadingState());
    } else {
      emit(SearchLoadingMoreState());
    }

    final result = await searchRepo.searchProducts(
      query: query,
      page: page,
    );

    if (isClosed) return;

    result.fold(
      (error) {
        emit(SearchErrorState(error));
      },
      (newProducts) {
        if (page == 1) {
          products = List<ProductModel>.from(newProducts);
        } else {
          products = [
            ...products,
            ...newProducts,
          ];
        }

        _currentPage = page;

        _hasMore = newProducts.length >= 10;

        if (products.isEmpty) {
          emit(SearchEmptyState(query));
          return;
        }

        emit(
          SearchProductsSuccessState(
            products: products,
            hasMore: _hasMore,
          ),
        );
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isClosed) return;

    if (currentFilter != SearchFilter.product) {
      return;
    }

    if (currentQuery.isEmpty) {
      return;
    }

    if (!_hasMore) {
      return;
    }

    await searchProducts(
      query: currentQuery,
      page: _currentPage + 1,
    );
  }

  void _searchCategoriesLocally(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    final results = allCategories.where((category) {
      final name = category.name?.toLowerCase() ?? '';

      return name.contains(normalizedQuery);
    }).toList();

    if (results.isEmpty) {
      emit(SearchEmptyState(query));
      return;
    }

    emit(
      SearchCategoriesSuccessState(results),
    );
  }

  void _searchBrandsLocally(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    final results = allBrands.where((brand) {
      final name = brand.name?.toLowerCase() ?? '';

      return name.contains(normalizedQuery);
    }).toList();

    if (results.isEmpty) {
      emit(SearchEmptyState(query));
      return;
    }

    emit(
      SearchBrandsSuccessState(results),
    );
  }
}