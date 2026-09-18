import 'package:dartz/dartz.dart';
import 'package:marketi/core/helper/cache_helper.dart';
import 'package:marketi/core/network/api/end_points.dart';
import 'package:marketi/features/profile/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<String, ProfileModel>> getProfileData();
}

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<Either<String, ProfileModel>> getProfileData() async {
    try {
      final cache = CacheHelper();
      final name = cache.getDataString(key: ApiKey.name);
      final email = cache.getDataString(key: ApiKey.email);
      final phone = cache.getDataString(key: ApiKey.phone);
      final image = cache.getDataString(key: ApiKey.image);

      if (name == null && email == null && phone == null) {
        return const Left('Please log in to view your profile');
      }

      return Right(
        ProfileModel(
          name: name,
          email: email,
          phone: phone,
          image: image,
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}