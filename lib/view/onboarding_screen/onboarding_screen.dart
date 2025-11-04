import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/onboarding_cubit/onboarding_cubit.dart';
import 'widgets/onboarding_bottom.dart';
import 'widgets/onboarding_indicator.dart';

import 'widgets/onboarding_page_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnboardingCubit(),
      child: Scaffold(
        body: Column(
          children: [
            OnBoardingPageView(),
            const OnBoardingIndicator(),
            const OnBoardingBottom(),
          ],
        ),
      ),
    );
  }
}
