import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_plan/data/models/meal_model.dart';

import '../../core/theme/colors.dart';
import '../../cubit/plan_meals_cubit/plan_meals_cubit.dart';
import '../company_profile_screen/widgets/custom_icon_button.dart';
import '../shared_widget/filter_sorting_buttons.dart';
import 'widgets/meal_list_item.dart';

class PlanMealsScreen extends StatefulWidget {
  final String planId;

  const PlanMealsScreen({Key? key, required this.planId}) : super(key: key);

  @override
  State<PlanMealsScreen> createState() => _PlanMealsScreenState();
}

class _PlanMealsScreenState extends State<PlanMealsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlanMealsCubit>().getCompanyPlans(widget.planId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomCompanyInfoBar(company: company),
      body: SafeArea(
        child: BlocBuilder<PlanMealsCubit, PlanMealsState>(
          builder: (context, state) {
            if (state is GetPlanMealsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetPlanMealsFailState) {
              return Center(
                child: Text(state.errorMsg),
              );
            }
            if (state is GetPlanMealsSuccessState) {
              return DefaultTabController(
                length: state.kinds.length,
                child: NestedScrollView(
                  headerSliverBuilder: (ctx, _) => [
                    SliverAppBar(
                      backgroundColor: const Color(0xFFD4D9EB),
                      expandedHeight: 260,
                      leadingWidth: 70,
                      leading: Align(
                        alignment: Alignment.centerRight,
                        child: CustomIconButton(
                          imageUrl: 'assets/icons/arrow_left.svg',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                'Popular Meals in this Plan',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Our dietitian specialist prepared for you balanced meal plan for every day. ',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color:
                                            AppColors.black.withOpacity(0.64)),
                              ),
                              const SizedBox(height: 24 + kToolbarHeight),
                            ],
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(kToolbarHeight),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: const Color(0xFFD4D9EB),
                            width: double.infinity,
                            child: TabBar(
                              padding: const EdgeInsets.only(left: 18),
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              unselectedLabelStyle:
                                  Theme.of(context).textTheme.bodyLarge,
                              labelStyle:
                                  Theme.of(context).textTheme.headlineLarge,
                              labelColor: AppColors.primaryColor,
                              unselectedLabelColor:
                                  AppColors.black.withOpacity(0.4),
                              isScrollable: true,
                              tabs: [
                                ...state.kinds.map((e) => Tab(text: e)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SliverPersistentHeader(
                    //   pinned: true,
                    //   delegate: PersistentHeader(
                    //     widget: Container(
                    //       color: const Color(0xFFD4D9EB),
                    //       width: double.infinity,
                    //       child: TabBar(
                    //         padding: const EdgeInsets.only(left: 18),
                    //         indicatorPadding:
                    //             const EdgeInsets.symmetric(horizontal: 10),
                    //         unselectedLabelStyle:
                    //             Theme.of(context).textTheme.bodyLarge,
                    //         labelStyle: Theme.of(context).textTheme.headlineLarge,
                    //         labelColor: AppColors.primaryColor,
                    //         unselectedLabelColor: AppColors.black.withOpacity(0.4),
                    //         isScrollable: true,
                    //         tabs: const [
                    //           Tab(
                    //             text: 'Breakfast',
                    //           ),
                    //           Tab(
                    //             text: 'Launch',
                    //           ),
                    //           Tab(
                    //             text: 'Snack',
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     tapsHeight: kToolbarHeight,
                    //   ),
                    // ),
                  ],
                  body: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            right: 16, left: 16, top: 24, bottom: 26),
                        child: FilterSortingButtons(),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: List.generate(
                            state.kinds.length,
                            (pageIndex) {
                              List<MealModel> meals = state.meals.where((meal) {
                                return meal.kind == state.kinds[pageIndex];
                              }).toList();
                              return ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: meals.length,
                                itemBuilder: (ctx, index) {
                                  return MealListItem(meal: meals[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

// class PersistentHeader extends SliverPersistentHeaderDelegate {
//   final Widget widget;
//   final double tapsHeight;
//
//   PersistentHeader({required this.tapsHeight, required this.widget});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       height: tapsHeight,
//       child: widget,
//     );
//   }
//
//   @override
//   double get maxExtent => tapsHeight;
//
//   @override
//   double get minExtent => tapsHeight;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
