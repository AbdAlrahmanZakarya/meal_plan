import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_plan/core/static_data.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingInitialState());
  int currentPage = 0;

  // static const List<OnBoardingModel> onBoardingList = [
  //   OnBoardingModel(
  //     title: 'Find a Meal Plan For Your\ndiet.',
  //     description: 'Several Meals Plan Companies in One Place.',
  //     image: 'assets/images/onboarding_images/onboarding-1.png',
  //   ),
  //   OnBoardingModel(
  //     title: 'Browse Companies profile,\nPlans And Meals.',
  //     description: 'Wide Variety of Meals, with Plans that fit Your Diet.',
  //     image: 'assets/images/onboarding_images/onboarding-2.png',
  //   ),
  //   OnBoardingModel(
  //     title: 'Connect with companies, Get\ncloser to your goal.',
  //     description: 'Contact companies to get the right plan for you.',
  //     image: 'assets/images/onboarding_images/onboarding-3.png',
  //   ),
  // ];

  void onPageChange(int index) {
    currentPage = index;
    emit(OnboardingPageChangeState(currentPage: index));
  }

  void toNextPage() {
    if (currentPage > StaticData.onBoardingList.length - 2) {
      return;
    } else {
      emit(
        OnboardingNextPageState(nextPage: ++currentPage),
      );
    }
  }
}
