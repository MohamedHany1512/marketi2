import 'package:dartz/dartz.dart';
import 'package:marketi/core/network/api/api_consumer.dart';
import 'package:marketi/core/network/api/end_points.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

abstract class SearchRepo {
  Future<Either<String, List<ProductModel>>> searchProducts({
    required String query,
    required int page,
  });
}

class SearchRepoImpl implements SearchRepo {
  final ApiConsumer api;

  SearchRepoImpl(this.api);

  @override
  Future<Either<String, List<ProductModel>>> searchProducts({
    required String query,
    required int page,
  }) async {
    try {
      const limit = 10;
      final skip = (page - 1) * limit;

      final response = await api.post(
        EndPoint.productsFilter,
        data: {
          'search': query,
          'skip': skip,
          'limit': limit,
        },
      );

      final listJson = response['list'] as List? ?? [];

      final products = listJson
          .map(
            (e) => ProductModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }
}