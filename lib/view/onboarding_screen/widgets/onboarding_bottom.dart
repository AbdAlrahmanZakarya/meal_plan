import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/static_data.dart';
import '../../../cubit/onboarding_cubit/onboarding_cubit.dart';

class OnBoardingBottom extends StatelessWidget {
  const OnBoardingBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, bottom: 12),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state.currentPage == StaticData.onBoardingList.length - 1) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to login page.
                },
                child: const Text('GET STARTED'),
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // TODO: Navigate to login page.
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
              ElevatedButton(
                child: const Text('Next'),
                onPressed: () {
                  context.read<OnboardingCubit>().toNextPage();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
