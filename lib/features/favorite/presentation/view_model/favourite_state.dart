import 'package:marketi/features/home/data/models/product_model.dart';

abstract class FavouriteState {}

class FavouriteInitialState extends FavouriteState {}
class GetFavoritesLoadingState extends FavouriteState {}
class GetFavoritesSuccessState extends FavouriteState {
  final List<ProductModel> favorites;
  GetFavoritesSuccessState(this.favorites);
}
class GetFavoritesErrorState extends FavouriteState {
  final String error;
  GetFavoritesErrorState(this.error);
}

class ToggleFavoriteSuccessState extends FavouriteState {
  final String message;
  final String productId;
  final bool isFav;
  ToggleFavoriteSuccessState({required this.message, required this.productId, required this.isFav});
}
class ToggleFavoriteErrorState extends FavouriteState {
  final String error;
  ToggleFavoriteErrorState(this.error);
}