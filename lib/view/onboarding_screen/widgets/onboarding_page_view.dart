import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_plan/core/static_data.dart';
import 'package:meal_plan/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../cubit/onboarding_cubit/onboarding_cubit.dart';
import '../../../data/models/onboarding_model.dart';

class OnBoardingPageView extends StatelessWidget {
  OnBoardingPageView({Key? key}) : super(key: key);
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> onBoardingList = StaticData.onBoardingList;

    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingNextPageState) {
          _controller.animateToPage(
            state.currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      },
      child: Expanded(
        // flex: 6,
        child: PageView.builder(
          controller: _controller,
          itemCount: onBoardingList.length,
          onPageChanged: context.read<OnboardingCubit>().onPageChange,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: 100.w,
                  child: Image.asset(
                    onBoardingList[index].image,
                    width: 100.w,
                    height: 55.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        onBoardingList[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        onBoardingList[index].description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.black.withOpacity(0.64)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
/*
class TestScreenState extends State<TestScreen> {
  final PageController _pageController = PageController(initialPage: 4);
  double page = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit, TestState>(listener: (context, state) async {
      if (state is DeviceLogsInitial) {
        await _animateTo(3);
      }
      if (state is ShowPage) {
        await _animateTo(state.page);
      }
    }, builder: (context, state) {
      // _log.info('Building dialog : page ${_pageController.page}');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Test'), // ${_pageController.page}'),
          actions: [
            TextButton(
                onPressed: () {
                  page = _nextPage(page);
                  BlocProvider.of<TestCubit>(context).animate(page);
                },
                child: const Text('swipe'))
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            Page0(),
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
      );
    });
  }

  double _nextPage(double page) {
    if (page > 3) {
      page = 0;
    } else {
      page = page + 1;
    }
    return page;
  }

  Future<void> _animateTo(double _page) async {
    _pageController.animateTo(
      _page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  Future<void> animate(double page) async {
    emit(ShowPage(page));
  }
}*/
