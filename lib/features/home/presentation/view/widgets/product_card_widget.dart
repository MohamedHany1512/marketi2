import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/themes/app_colors.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:marketi/features/favorite/presentation/view_model/favourite_cubit.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/presentation/view/widgets/favourite_button.dart';
import 'package:marketi/features/home/presentation/view/widgets/product_image.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;

  const ProductCardWidget({super.key, required this.product});

  double get discountedPrice {
    return product.price - (product.price * product.discountPercentage / 100);
  }

  String? get imageUrl {
    if (product.thumbnail.isNotEmpty) return product.thumbnail;
    if (product.images.isNotEmpty) return product.images.first;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavouriteCubit, bool>(
      (cubit) => cubit.isFavorite(product.id.toString()),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.discountPercentage > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        color: AppColors.backgroundLight,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 22.h),
                FavoriteButton(
                  isFavorite: isFavorite,
                  onPressed: () =>
                      context.read<FavouriteCubit>().toggleFavorite(product),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            Expanded(
              child: Center(child: ProductImage(imageUrl: imageUrl)),
            ),

            SizedBox(height: 6.h),

            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 5.h),

            Row(
              children: [
                Text(
                  '\$${discountedPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                if (product.discountPercentage > 0) ...[
                  SizedBox(width: 5.w),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),

            SizedBox(height: 4.h),

            Row(
              children: [
                Icon(Icons.star, size: 14.sp, color: Colors.amber),
                SizedBox(width: 3.w),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            SizedBox(
              width: double.infinity,
              height: 32.h,
              child: OutlinedButton(
                onPressed: () {
                  context.read<CartCubit>().addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Product added to cart'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
