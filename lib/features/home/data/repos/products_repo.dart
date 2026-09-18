import 'package:dartz/dartz.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/end_points.dart';
import '../models/brand_model.dart';
import '../models/category_model.dart';

abstract class ProductsRepo {
  Future<Either<String, List<CategoryModel>>> getCategories();
  Future<Either<String, List<BrandModel>>> getBrands();
  Future<Either<String, List<ProductModel>>> getProducts({required int page});

  Future<Either<String, List<ProductModel>>> getProductsByCategory({
    required String categoryName,
    int skip = 0,
    int limit = 10,
  });

  Future<Either<String, List<ProductModel>>> getProductsByBrand({
    required String brandName,
    int skip = 0,
    int limit = 10,
  });
}

class ProductsRepoImpl implements ProductsRepo {
  final ApiConsumer apiConsumer;

  ProductsRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, List<ProductModel>>> getProductsByCategory({
    required String categoryName,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await apiConsumer.get(
        EndPoint.getCategoryProducts(categoryName),
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final products = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductsByBrand({
    required String brandName,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await apiConsumer.get(
        EndPoint.getBrandProducts(brandName),
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final products = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await apiConsumer.get('/home/categories');
      final list = (response['list'] as List)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BrandModel>>> getBrands() async {
    try {
      final response = await apiConsumer.get('/home/brands');
      final list = (response['list'] as List)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProducts({
    required int page,
  }) async {
    try {
      const limit = 10;
      final skip = (page - 1) * limit;

      final response = await apiConsumer.get(
        '/home/products',
        queryParameters: {'skip': skip, 'limit': limit},
      );

      final list = (response['list'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(list);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
