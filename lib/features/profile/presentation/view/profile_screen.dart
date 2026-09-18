import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/services/services_locator.dart';
import 'package:marketi/core/themes/app_colors.dart';
import 'package:marketi/features/profile/presentation/view/widgets/info_tile.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/view_model/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is ProfileErrorState) {
              return Center(
                child: Container(
                  margin: EdgeInsets.all(24.w),
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 48.sp,
                        color: AppColors.error,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Unable to load profile',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.error,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton.icon(
                        onPressed: () =>
                            context.read<ProfileCubit>().getProfile(),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileSuccessState) {
              final user = state.profile;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 30.h),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primary, AppColors.primaryDark],
                          ),
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 12.r,
                              offset: Offset(0, 8.h),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 54.r,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      user.image != null &&
                                          user.image!.isNotEmpty
                                      ? NetworkImage(user.image!)
                                      : null,
                                  child:
                                      user.image == null || user.image!.isEmpty
                                      ? Icon(
                                          Icons.person_rounded,
                                          size: 58.sp,
                                          color: AppColors.primary,
                                        )
                                      : null,
                                ),
                                Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.verified_rounded,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18.h),
                            Text(
                              user.name ?? 'No Name',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Customer profile',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account Details',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      InfoTile(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: user.email ?? 'Not provided',
                      ),
                      InfoTile(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: user.phone ?? 'Not provided',
                      ),
                      InfoTile(
                        icon: Icons.location_on_outlined,
                        label: 'Address',
                        value: user.address ?? 'Not added',
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
