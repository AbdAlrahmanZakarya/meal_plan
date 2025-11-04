import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/colors.dart';
import '../../cubit/company_plans_cubit/company_plans_cubit.dart';
import '../../cubit/favorites_cubit/favorite_plans_cubit/favorite_plans_cubit.dart';
import '../../data/models/plan_model.dart';
import '../shared_widget/plan_list_item.dart';

class CompanyPlansTabBarView extends StatefulWidget {
  final String companyId;

  const CompanyPlansTabBarView({
    super.key,
    required this.companyId,
  });

  @override
  State<CompanyPlansTabBarView> createState() => _CompanyPlansTabBarViewState();
}

class _CompanyPlansTabBarViewState extends State<CompanyPlansTabBarView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  // final PageController pageController = PageController();
  // int currentTab = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<FavoritePlansCubit>().getFavoritePlans();
    context.read<CompanyPlansCubit>().getCompanyPlans(widget.companyId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CompanyPlansCubit, CompanyPlansState>(
      builder: (context, state) {
        if (state is GetCompanyPlansLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetCompanyPlansFailState) {
          return Center(
            child: Text(state.errorMsg),
          );
        }

        if (state is GetCompanyPlansSuccessState) {
          _tabController = TabController(
            length: state.tags.length + 1,
            vsync: this,
            // initialIndex: currentTab,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              //13 + 18 = 31
              TabBar(
                controller: _tabController,
                // onTap: (val) {
                //   currentTab = val;
                //   pageController.animateToPage(
                //     val,
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeIn,
                //   );
                // },
                unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
                labelStyle: Theme.of(context).textTheme.headlineLarge,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.black.withOpacity(0.4),
                isScrollable: true,
                tabs: [
                  const Tab(text: 'All Plans'),
                  ...state.tags.map(
                    (String e) => Tab(
                      text: e, // 19
                    ),
                  ),
                ],
              ),
              // Expanded(
              //   child: PageView.builder(
              //     onPageChanged: (val) {
              //       currentTab = val;
              //       _tabController.animateTo(val);
              //     },
              //     controller: pageController,
              //     itemCount: state.tags.length + 1,
              //     itemBuilder: (ctx, pageIndex) {
              //       // if (pageIndex == 1) {
              //       //   return ListView.builder(
              //       //     itemCount: state.plans.length,
              //       //     itemBuilder: (ctx, index) {
              //       //       return PlanListItem(plan: state.plans[index]);
              //       //     },
              //       //   );
              //       // }
              //       List<PlanModel> plans = pageIndex == 0
              //           ? state.plans
              //           : state.plans.where((element) {
              //               return element.tag == state.tags[pageIndex - 1];
              //               // return element.tags.contains(
              //               //   state.tags[pageIndex - 1],
              //               // );
              //             }).toList();
              //       return ListView.builder(
              //         padding: const EdgeInsets.symmetric(horizontal: 16),
              //         itemCount: plans.length,
              //         itemBuilder: (ctx, index) {
              //           return PlanListItem(plan: plans[index]);
              //         },
              //       );
              //     },
              //   ),
              //
              //   // TabBarView(
              //   //   // physics: NeverScrollableScrollPhysics(),
              //   //   children: [
              //   //     ListView.builder(
              //   //       itemCount: state.plans.length,
              //   //       itemBuilder: (ctx, index) {
              //   //         return PlanListItem(plan: state.plans[index]);
              //   //       },
              //   //     ),
              //   //     ...state.tags.map(
              //   //       (tag) {
              //   //         print(tag);
              //   //         List<PlanModel> filteredPlans = state.plans
              //   //             .where((element) => element.tags.contains(tag))
              //   //             .toList();
              //   //         return ListView.builder(
              //   //           itemCount: filteredPlans.length,
              //   //           itemBuilder: (ctx, index) {
              //   //             return PlanListItem(plan: filteredPlans[index]);
              //   //           },
              //   //         );
              //   //       },
              //   //     ),
              //   //   ],
              //   // ),
              // ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ...List.generate(
                      state.tags.length + 1,
                      (pageIndex) {
                        List<PlanModel> plans = pageIndex == 0
                            ? state.plans
                            : state.plans.where((element) {
                                return element.tag == state.tags[pageIndex - 1];
                                // return element.tags.contains(
                                //   state.tags[pageIndex - 1],
                                // );
                              }).toList();
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: plans.length,
                          itemBuilder: (ctx, index) {
                            return PlanListItem(plan: plans[index]);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Center(
          child: Text('Unknown error.'),
        );
      },
    );
  }
}
