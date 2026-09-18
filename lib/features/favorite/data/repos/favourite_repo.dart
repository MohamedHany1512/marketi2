import 'package:dartz/dartz.dart';
import 'package:marketi/core/network/api/api_consumer.dart';
import 'package:marketi/core/network/api/end_points.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

abstract class FavouriteRepo {
  Future<Either<String, List<ProductModel>>> getFavorites();
  Future<Either<String, String>> addFavorite(String productId);
  Future<Either<String, String>> deleteFavorite(String productId);
}

class FavouriteRepoImpl implements FavouriteRepo {
  final ApiConsumer api;
  FavouriteRepoImpl(this.api);

  @override
  Future<Either<String, List<ProductModel>>> getFavorites() async {
    try {
      final response = await api.get(EndPoint.getFavorite);
      final List listJson = response['list'] ?? response['favorites'] ?? [];
      final products = listJson.map((e) => ProductModel.fromJson(e)).toList();
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addFavorite(String productId) async {
    try {
      final response = await api.post(
        EndPoint.addFavorite,
        data: {'productId': productId},
      );
      return Right(response['message'] ?? 'Added to favourites');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteFavorite(String productId) async {
    try {
      final response = await api.delete(
        EndPoint.deleteFavorite,
        data: {'productId': productId},
      );
      return Right(response['message'] ?? 'Removed from favourites');
    } catch (e) {
      return Left(e.toString());
    }
  }
}