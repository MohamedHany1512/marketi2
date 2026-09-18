import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketi/core/services/services_locator.dart';

import 'package:marketi/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:marketi/features/auth/login/presentation/views/login_view.dart';
import 'package:marketi/features/auth/sign_up/presentation/view/sign_up_screen.dart';
import 'package:marketi/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:marketi/features/cart/presentation/view/cart_screen.dart';
import 'package:marketi/features/favorite/presentation/view/favourite_screen.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_cubit.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/presentation/view/all_brands_view.dart';
import 'package:marketi/features/home/presentation/view/all_categories_view.dart';
import 'package:marketi/features/home/presentation/view/all_products_view.dart';
import 'package:marketi/features/home/presentation/view/brand_products_view.dart';
import 'package:marketi/features/home/presentation/view/category_products_view.dart';
import 'package:marketi/features/home/presentation/view/home_view.dart';
import 'package:marketi/features/home/presentation/view/product_details_view.dart';
import 'package:marketi/features/home/presentation/view_model/products_cubit.dart';

import 'package:marketi/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:marketi/features/onboarding/presentation/view/on_boarding_view.dart';
import 'package:marketi/features/payment/presentation/view/paymob_webview_screen.dart';
import 'package:marketi/features/payment/presentation/view_model/cubit/check_out_cubit.dart';
import 'package:marketi/features/profile/presentation/view/profile_screen.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:marketi/features/search/presentation/view/search_screen.dart';
import 'package:marketi/features/search/presentation/view_model/search_cubit.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OnboardingCubit>(
            create: (_) => OnboardingCubit(),
            child: const OnBoardingView(),
          ),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (_) => sl<LoginCubit>(),
            child: const LoginView(),
          ),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductsCubit>(
            create: (_) => sl<ProductsCubit>()..fetchHomeData(),
            child: const HomeView(),
          ),
        );
      case AppRoutes.categories:
        final categories = settings.arguments as List<CategoryModel>;
        return MaterialPageRoute(
          builder: (_) => AllCategoriesView(categories: categories),
        );

      case AppRoutes.products:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductsCubit>(
            create: (_) =>
                sl<ProductsCubit>()
                  ..initializeProducts(args['products'] as List<ProductModel>),
            child: AllProductsView(title: args['title'] as String),
          ),
        );

      case AppRoutes.brands:
        final brands = settings.arguments as List<BrandModel>;
        return MaterialPageRoute(builder: (_) => AllBrandsView(brands: brands));

      case AppRoutes.productDetails:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(product: product),
        );
      case AppRoutes.categoryProducts:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CategoryProductsView(categoryName: categoryName),
        );
      case AppRoutes.brandProducts:
        return MaterialPageRoute(
          builder: (_) =>
              BrandProductsView(brandName: settings.arguments as String),
        );
      case AppRoutes.favourite:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FavouriteCubit>(
            child: const FavouriteScreen(),

            create: (context) => sl<FavouriteCubit>()..getFavorites(),
          ),
        );
      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>(
                create: (_) => sl<ProfileCubit>()..getProfile(),
              ),
              BlocProvider<CheckoutCubit>(create: (_) => sl<CheckoutCubit>()),
            ],
            child: const CartScreen(),
          ),
        );
      case AppRoutes.search:
        final args = settings.arguments as Map<String, dynamic>? ?? const {};

        final categories =
            (args['categories'] as List<CategoryModel>?) ??
            const <CategoryModel>[];
        final brands =
            (args['brands'] as List<BrandModel>?) ?? const <BrandModel>[];

        return MaterialPageRoute(
          builder: (_) => BlocProvider<SearchCubit>(
            create: (_) {
              final cubit = sl<SearchCubit>();
              cubit.allCategories = List<CategoryModel>.from(categories);
              cubit.allBrands = List<BrandModel>.from(brands);
              return cubit;
            },
            child: SearchScreen(categories: categories, brands: brands),
          ),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ProfileCubit>()..getProfile(),
            child: const ProfileScreen(),
          ),
        );
      case AppRoutes.paymobWebViewScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PaymobWebViewScreen(
            paymentToken: args['paymentToken'],
            iframeId: args['iframeId'],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
