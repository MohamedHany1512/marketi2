import 'package:dartz/dartz.dart';
import 'package:marketi/core/network/api/api_consumer.dart';
import 'package:marketi/core/network/api/end_points.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

abstract class CartRepo {
  Future<Either<String, List<ProductModel>>> getCart();
  Future<Either<String, String>> addToCart(String productId);
  Future<Either<String, String>> removeFromCart(String productId);
}

class CartRepoImpl implements CartRepo {
  final ApiConsumer api;
  CartRepoImpl(this.api);

  @override
  Future<Either<String, List<ProductModel>>> getCart() async {
    try {
      final response = await api.get(EndPoint.getCart);
      final List listJson = response['list'] ?? response['cart'] ?? [];
        final products = listJson
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addToCart(String productId) async {
    try {
      final response = await api.post(
        EndPoint.addToCart,
        data: {'productId': productId},
      );
      return Right(response['message'] ?? 'Added to cart successfully');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> removeFromCart(String productId) async {
    try {
      final response = await api.delete(
        EndPoint.removeFromCart(productId),
      );
      return Right(response['message'] ?? 'Removed from cart successfully');
    } catch (e) {
      return Left(e.toString());
    }
  }
}