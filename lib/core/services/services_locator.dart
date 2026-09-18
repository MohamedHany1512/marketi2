import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:marketi/core/network/api/api_consumer.dart';
import 'package:marketi/core/network/api/dio_consumer.dart';

import 'package:marketi/features/auth/login/data/repo/login_repository.dart';
import 'package:marketi/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:marketi/features/auth/sign_up/data/repo/sign_up_repo.dart';
import 'package:marketi/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_cubit.dart';

import 'package:marketi/features/home/data/repos/products_repo.dart';
import 'package:marketi/features/home/presentation/view_model/products_cubit.dart';
import 'package:marketi/features/favorite/data/repos/favourite_repo.dart';
import 'package:marketi/features/payment/data/repos/checkout_repo.dart';
import 'package:marketi/features/payment/presentation/view_model/cubit/check_out_cubit.dart';
import 'package:marketi/features/profile/data/repos/profile_repo.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:marketi/features/search/data/repos/search_repo.dart';
import 'package:marketi/features/search/presentation/view_model/search_cubit.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // =========================
  // Network
  // =========================

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl<Dio>()));

  // =========================
  // Login
  // =========================

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepository(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<LoginCubit>(
    () => LoginCubit(repository: sl<LoginRepository>()),
  );
  // =========================
  // signup
  // =========================

  sl.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<SignUpCubit>(() => SignUpCubit(repo: sl<SignUpRepo>()));

  // =========================
  // Products
  // =========================
  sl.registerLazySingleton<ProductsRepo>(
    () => ProductsRepoImpl(apiConsumer: sl<ApiConsumer>()),
  );

  sl.registerFactory<ProductsCubit>(() => ProductsCubit(sl<ProductsRepo>()));

  // =========================
  // favourite
  // =========================
  sl.registerLazySingleton<FavouriteRepo>(
    () => FavouriteRepoImpl(sl<ApiConsumer>()),
  );
  sl.registerFactory<FavouriteCubit>(() => FavouriteCubit(sl<FavouriteRepo>()));


// داخل setupServiceLocator()
sl.registerLazySingleton<CartCubit>(() => CartCubit());

// Search Repository
sl.registerLazySingleton<SearchRepo>(
  () => SearchRepoImpl(sl<ApiConsumer>()),
);

// Search Cubit
sl.registerFactory<SearchCubit>(
  () => SearchCubit(sl<SearchRepo>()),
);

// Profile Repository
sl.registerLazySingleton<ProfileRepo>(
  () => ProfileRepoImpl(),
);

// Profile Cubit
sl.registerFactory<ProfileCubit>(
  () => ProfileCubit(sl<ProfileRepo>()),
);


// Checkout
sl.registerLazySingleton<CheckoutRepo>(
  () => CheckoutRepo(apiConsumer: sl<ApiConsumer>()),
);

sl.registerFactory<CheckoutCubit>(
  () => CheckoutCubit(checkoutRepo: sl<CheckoutRepo>()),
);
}
