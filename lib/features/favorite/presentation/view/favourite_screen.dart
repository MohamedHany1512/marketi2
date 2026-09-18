// inside favourite_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_cubit.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_state.dart';
import 'package:marketi/features/home/presentation/view/widgets/product_card_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'), centerTitle: true),
      body: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          if (state is ToggleFavoriteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (state is ToggleFavoriteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<FavouriteCubit>();

          if (state is GetFavoritesLoadingState &&
              cubit.favoriteProducts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cubit.favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text(
                    'No favourite items yet',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: cubit.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = cubit.favoriteProducts[index];
              return ProductCardWidget(product: product);
            },
          );
        },
      ),
    );
  }
}
