import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/onboarding/data/models/on_boarding_pages.dart';
import 'package:marketi/features/onboarding/presentation/cubit/on_boarding_states.dart';



class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  final PageController pageController = PageController();

  int get pageCount => onboardingPages.length;

  void onPageChanged(int index) {
    emit(
      OnboardingState(
        currentPage: index,
      ),
    );
  }

  void nextPage() {
    if (state.currentPage < pageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }



  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}