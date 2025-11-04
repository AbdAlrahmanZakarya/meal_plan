import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/colors.dart';
import '../../cubit/favorites_cubit/favorite_companies_cubit/favorite_companies_cubit.dart';
import '../../cubit/favorites_cubit/favorite_plans_cubit/favorite_plans_cubit.dart';
import '../shared_widget/sliding_segmented_control_widget.dart';
import 'widgets/company_grid_view.dart';
import '../shared_widget/plan_list_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('Favorites initState');
    super.initState();
    context.read<FavoritePlansCubit>().getFavoritePlans();
    context.read<FavoriteCompaniesCubit>().getFavoriteCompanies();
  }

  int x = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [
        //----------------------------- Header -------------------------------
        SliverPadding(
          padding: const EdgeInsets.only(top: 54, right: 16, left: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //----------------------- Header Texts -----------------------
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'You can easily get to what you favorite.',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.64),
                      ),
                ),
                const SizedBox(height: 20),
                //-------------------------- Tab bar ------------------------
                SlidingSegmentedControlWidget(
                  onValueChanged: (val) {
                    setState(() {
                      x = val ?? 0;
                    });
                  },
                  tab1Text: 'Plans',
                  tab2Text: 'Companies',
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
        //-------------------------- Meals List ------------------------------
        x == 0
            ? BlocBuilder<FavoritePlansCubit, FavoritePlansState>(
                builder: (context, state) {
                  if (state is GetFavoritePlansLoadingState) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(width: 10),
                            Text('Loading...')
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is GetFavoritePlansSuccessState) {
                    if (state.favoritePlans.isNotEmpty) {
                      return SliverPadding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return PlanListItem(
                                  plan: state.favoritePlans[index]);
                            },
                            childCount: state.favoritePlans.length,
                          ),
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('No Favorite Plans To Show.'),
                        ),
                      );
                    }
                  }
                  if (state is GetFavoritePlansFailState) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(state.errorMessage),
                      ),
                    );
                  }
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Loading 1...'),
                    ),
                  );
                },
              )
            : BlocBuilder<FavoriteCompaniesCubit, FavoriteCompaniesState>(
                builder: (ctx, state) {
                  if (state is GetFavoriteCompaniesLoadingState) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(width: 10),
                            Text('Loading...')
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is GetFavoriteCompaniesSuccessState) {
                    if (state.favoriteCompanies.isNotEmpty) {
                      return SliverPadding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 24),
                        sliver:
                            CompanyGridView(companies: state.favoriteCompanies),
                      );
                    } else {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('No Favorite Companies To Show.'),
                        ),
                      );
                    }
                    // return SliverPadding(
                    //   padding: const EdgeInsets.only(
                    //       right: 16, left: 16, bottom: 24),
                    //   sliver: SliverList(
                    //     delegate: SliverChildBuilderDelegate(
                    //           (context, index) {
                    //         return PlanListItem(
                    //             plan: state.favoritePlans[index]);
                    //       },
                    //       childCount: state.favoritePlans.length,
                    //     ),
                    //   ),
                    // );
                  }
                  if (state is GetFavoriteCompaniesFailState) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(state.errorMessage),
                      ),
                    );
                  }
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Loading 2...'),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
