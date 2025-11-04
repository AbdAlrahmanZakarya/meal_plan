import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_plan/core/static_data.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../../cubit/onboarding_cubit/onboarding_cubit.dart';

class OnBoardingIndicator extends StatelessWidget {
  const OnBoardingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 4.h),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              StaticData.onBoardingList.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(5),
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  color: state.currentPage == index
                      ? AppColors.primaryColor
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 0.5,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
