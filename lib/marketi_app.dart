import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/core/services/services_locator.dart';
import 'package:marketi/core/themes/app_theme.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_cubit.dart';

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavouriteCubit>(
          create: (context) => sl<FavouriteCubit>()..getFavorites(),
        ),
        BlocProvider<CartCubit>(create: (context) => sl<CartCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.onBoarding,
          title: 'Marketi',
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
