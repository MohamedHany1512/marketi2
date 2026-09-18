import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketi/features/onboarding/data/models/on_boarding_model.dart';
import 'package:marketi/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:marketi/features/onboarding/presentation/cubit/on_boarding_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 280.h,
            width: double.infinity,
            child: SvgPicture.asset(page.image, fit: BoxFit.contain),
          ),

          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final cubit = context.read<OnboardingCubit>();

              return SizedBox(
                height: 30.h,
                child: SmoothPageIndicator(
                  controller: cubit.pageController,
                  count: cubit.pageCount,
                  effect: ExpandingDotsEffect(
                    dotHeight: 20.h,
                    dotWidth: 20.w,
                    spacing: 8.w,
                    activeDotColor: Theme.of(context).primaryColor,
                    expansionFactor: 1.01,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 24.h),

          Text(
            page.primaryText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 34.h),

          Text(
            page.secondaryText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
