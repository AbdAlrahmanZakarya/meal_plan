part of 'onboarding_cubit.dart';

@immutable
abstract class OnboardingState {
  final int currentPage;

  const OnboardingState(this.currentPage);
}

class OnboardingInitialState extends OnboardingState {
  const OnboardingInitialState()
      : super(0);
}

class OnboardingPageChangeState extends OnboardingState {
  const OnboardingPageChangeState({required int currentPage})
      : super(currentPage);
}

class OnboardingNextPageState extends OnboardingState {
  const OnboardingNextPageState({
    required int nextPage,
  }) : super(nextPage);
}
