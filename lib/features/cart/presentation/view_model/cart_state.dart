import 'package:marketi/features/home/data/models/product_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class GetCartSuccessState extends CartState {
  final List<ProductModel> cartProducts;
  GetCartSuccessState(this.cartProducts);
}

class AddToCartSuccessState extends CartState {
  final String message;
  AddToCartSuccessState(this.message);
}

class AddToCartErrorState extends CartState {
  final String error;
  AddToCartErrorState(this.error);
}

class RemoveFromCartSuccessState extends CartState {
  final String message;
  RemoveFromCartSuccessState(this.message);
}