import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/routing/app_routes.dart';
import 'package:marketi/core/themes/app_colors.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:marketi/features/cart/presentation/view_model/cart_state.dart';
import 'package:marketi/features/payment/data/models/paymob_constants.dart';
import 'package:marketi/features/payment/presentation/view_model/cubit/check_out_cubit.dart';
import 'package:marketi/features/payment/presentation/view_model/cubit/check_out_state.dart';
import 'package:marketi/features/profile/data/models/profile_model.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Map<String, dynamic> _buildBillingData(ProfileModel? profile) {
    final nameParts = (profile?.name ?? 'Customer').trim().split(
      RegExp(r'\s+'),
    );
    final firstName = nameParts.isNotEmpty ? nameParts.first : 'Customer';
    final lastName = nameParts.length > 1
        ? nameParts.sublist(1).join(' ')
        : 'User';

    final addressParts = (profile?.address ?? '')
        .split(',')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList();

    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': profile?.email ?? 'guest@example.com',
      'phone_number': profile?.phone ?? '+0000000000',
      'apartment': addressParts.isNotEmpty ? addressParts.first : 'NA',
      'floor': 'NA',
      'street': addressParts.length > 1
          ? addressParts.sublist(1).join(', ')
          : 'NA',
      'building': 'NA',
      'shipping_method': 'PKG',
      'postal_code': 'NA',
      'city': addressParts.length > 2 ? addressParts[1] : 'Cairo',
      'country': 'EGP',
      'state': 'NA',
    };
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileCubit>().state;
    final profile = profileState is ProfileSuccessState
        ? profileState.profile
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is RemoveFromCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.orange,
              ),
            );
          } else if (state is AddToCartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<CartCubit>();

          if (cubit.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Your Cart is Empty',
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

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: cubit.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cubit.cartItems[index];
                    final imageUrl = product.thumbnail.isNotEmpty
                        ? product.thumbnail
                        : product.images.isNotEmpty
                        ? product.images.first
                        : null;
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: imageUrl == null
                                ? null
                                : DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          child: imageUrl == null
                              ? const Icon(Icons.image_not_supported_outlined)
                              : null,
                        ),
                        title: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${product.price.toStringAsFixed(2)} EGP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<CartCubit>().removeFromCart(
                              product.id.toString(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Total & Checkout Bar
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.15),
                      blurRadius: 10.r,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        ),
                        Text(
                          '${cubit.totalPrice.toStringAsFixed(2)} EGP',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    BlocListener<CheckoutCubit, CheckoutState>(
                      listener: (context, state) {
                        if (state is CheckoutLoadingState) {
                          // عرض مؤشر التحميل
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is CheckoutSuccessState) {
                          // إغلاق التحميل
                          Navigator.pop(context);

                          // التوجيه لشاشة الـ WebView للعميل لكتابة بيانات الكارت
                          Navigator.pushNamed(
                            context,
                            AppRoutes.paymobWebViewScreen,
                            arguments: {
                              'paymentToken': state.paymentPaymentToken,
                              'iframeId': PaymobConstants.iframeId,
                            },
                          );
                        } else if (state is CheckoutErrorState) {
                          // إغلاق التحميل وعرض الخطأ
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          final billingData = _buildBillingData(profile);
                          final totalAmount = context
                              .read<CartCubit>()
                              .totalPrice;

                          context.read<CheckoutCubit>().payWithPaymob(
                            apiKey: PaymobConstants.apiKey,
                            integrationId: PaymobConstants.integrationId,
                            amount: totalAmount,
                            billingData: billingData,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
