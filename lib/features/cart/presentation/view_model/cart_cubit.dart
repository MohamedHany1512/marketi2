import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_state.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  // قائمة منتجات السلة المحفوظة في الذاكرة
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => List.unmodifiable(_cartItems);

  // حساب السعر الإجمالي
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.price));
  }

  // التحقق مما إذا كان المنتج موجوداً بالسلة
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.id.toString() == productId);
  }

  // إضافة منتج للسلة
  void addToCart(ProductModel product) {
    final productId = product.id.toString();
    if (!isInCart(productId)) {
      _cartItems.add(product);
      emit(AddToCartSuccessState('Added to cart successfully'));
      emit(GetCartSuccessState(List.from(_cartItems)));
    } else {
      emit(AddToCartErrorState('Item is already in cart'));
    }
  }

  // حذف منتج من السلة
  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.id.toString() == productId);
    emit(RemoveFromCartSuccessState('Removed from cart'));
    emit(GetCartSuccessState(List.from(_cartItems)));
  }

  // تفريغ السلة بالكامل (عند إتمام الشراء)
  void clearCart() {
    _cartItems.clear();
    emit(GetCartSuccessState([]));
  }
}