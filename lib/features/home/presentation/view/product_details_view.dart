import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/themes/app_colors.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_state.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.thumbnail.isNotEmpty
        ? product.thumbnail
        : product.images.isNotEmpty
        ? product.images.first
        : null;
    final discountedPrice =
        product.price - (product.price * product.discountPercentage / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AddToCartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة المنتج
                Center(
                  child: Container(
                    height: 250.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.grey[200],
                      image: imageUrl == null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.contain,
                            ),
                    ),
                    child: imageUrl == null
                        ? Icon(
                            Icons.image_not_supported,
                            size: 80.sp,
                            color: Colors.grey,
                          )
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.image_not_supported,
                              size: 80.sp,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20.h),

                // اسم المنتج
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),

                // السعر والتقييم
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${discountedPrice.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // الوصف
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  product.description.isEmpty
                      ? 'No description available for this product.'
                      : product.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(26),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            context.read<CartCubit>().addToCart(product);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            'Add to Cart',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
