import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/favorite/data/repos/favourite_repo.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_state.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepo favouriteRepo;
  FavouriteCubit(this.favouriteRepo) : super(FavouriteInitialState());

  List<ProductModel> favoriteProducts = [];
  Set<String> favoriteIds = {};

  void getFavorites() async {
    emit(GetFavoritesLoadingState());
    final result = await favouriteRepo.getFavorites();
    result.fold(
      (error) => emit(GetFavoritesErrorState(error)),
      (products) {
        favoriteProducts = products;
        favoriteIds = products.map((p) => p.id.toString()).toSet();
        emit(GetFavoritesSuccessState(favoriteProducts));
      },
    );
  }

  bool isFavorite(String productId) {
    return favoriteIds.contains(productId);
  }

  void toggleFavorite(ProductModel product) async {
    final productId = product.id.toString();
    final isFav = isFavorite(productId);

    if (isFav) {
      favoriteIds.remove(productId);
      favoriteProducts.removeWhere((p) => p.id.toString() == productId);
      emit(GetFavoritesSuccessState(List.from(favoriteProducts)));

      final result = await favouriteRepo.deleteFavorite(productId);
      result.fold(
        (error) {
          favoriteIds.add(productId);
          favoriteProducts.add(product);
          emit(ToggleFavoriteErrorState(error));
          emit(GetFavoritesSuccessState(List.from(favoriteProducts)));
        },
        (message) => emit(ToggleFavoriteSuccessState(message: message, productId: productId, isFav: false)),
      );
    } else {
      favoriteIds.add(productId);
      favoriteProducts.add(product);
      emit(GetFavoritesSuccessState(List.from(favoriteProducts)));

      final result = await favouriteRepo.addFavorite(productId);
      result.fold(
        (error) {
          favoriteIds.remove(productId);
          favoriteProducts.removeWhere((p) => p.id.toString() == productId);
          emit(ToggleFavoriteErrorState(error));
          emit(GetFavoritesSuccessState(List.from(favoriteProducts)));
        },
        (message) => emit(ToggleFavoriteSuccessState(message: message, productId: productId, isFav: true)),
      );
    }
  }
}