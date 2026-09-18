import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

import '../../data/repos/products_repo.dart';
import 'products_states.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;

  ProductsCubit(this.productsRepo) : super(const ProductsState());

  void initializeProducts(List<ProductModel> products) {
    emit(
      state.copyWith(
        products: products,
        currentPage: 1,
        hasMore: products.isNotEmpty,
        isLoading: false,
      ),
    );
  }

  Future<void> getProductsByCategory(String categoryName) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await productsRepo.getProductsByCategory(
      categoryName: categoryName,
    );
    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (products) => emit(
        state.copyWith(
          isLoading: false,
          products: products,
          currentPage: 1,
          hasMore: products.isNotEmpty,
        ),
      ),
    );
  }

  Future<void> getProductsByBrand(String brandName) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await productsRepo.getProductsByBrand(brandName: brandName);
    result.fold(
      (error) => emit(state.copyWith(isLoading: false, errorMessage: error)),
      (products) => emit(
        state.copyWith(
          isLoading: false,
          products: products,
          currentPage: 1,
          hasMore: products.isNotEmpty,
        ),
      ),
    );
  }

  Future<void> fetchHomeData() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final categoriesRes = await productsRepo.getCategories();
    final brandsRes = await productsRepo.getBrands();
    final productsRes = await productsRepo.getProducts(page: 1);

    List<CategoryModel> categories = [];
    List<BrandModel> brands = [];
    List<ProductModel> products = [];
    String? error;

    categoriesRes.fold((l) => error = l, (r) => categories = r);
    brandsRes.fold((l) => error = l, (r) => brands = r);
    productsRes.fold((l) => error = l, (r) => products = r);

    if (categories.isEmpty && products.isEmpty && error != null) {
      emit(state.copyWith(isLoading: false, errorMessage: error));
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        categories: categories,
        brands: brands,
        products: products,
        currentPage: 1,
        hasMore: products.isNotEmpty,
      ),
    );
  }

  Future<void> loadMoreProducts() async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, paginationErrorMessage: null));

    final nextPage = state.currentPage + 1;
    final result = await productsRepo.getProducts(page: nextPage);

    result.fold(
      (error) => emit(
        state.copyWith(isLoadingMore: false, paginationErrorMessage: error),
      ),
      (newProducts) {
        if (newProducts.isEmpty) {
          emit(state.copyWith(isLoadingMore: false, hasMore: false));
        } else {
          emit(
            state.copyWith(
              isLoadingMore: false,
              products: [...state.products, ...newProducts],
              currentPage: nextPage,
              hasMore: true,
            ),
          );
        }
      },
    );
  }
}
