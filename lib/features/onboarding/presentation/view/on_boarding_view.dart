import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/features/onboarding/data/models/on_boarding_pages.dart';
import 'package:marketi/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:marketi/features/onboarding/presentation/cubit/on_boarding_states.dart';
import 'package:marketi/features/onboarding/presentation/view/widgets/on_boarding_page.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  final cubit = context.read<OnboardingCubit>();

                  return PageView.builder(
                    controller: cubit.pageController,
                    itemCount: onboardingPages.length,
                    onPageChanged: cubit.onPageChanged,
                    itemBuilder: (context, index) {
                      return OnboardingPage(page: onboardingPages[index]);
                    },
                  );
                },
              ),
            ),

            SizedBox(height: 30.h),

            // Next / Get Started
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  final cubit = context.read<OnboardingCubit>();

                  final isLastPage = state.currentPage == cubit.pageCount - 1;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (isLastPage) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          cubit.nextPage();
                        }
                      },
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
