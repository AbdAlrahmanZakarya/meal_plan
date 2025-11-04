import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_plan/router.dart';

import '../../core/theme/colors.dart';
import '../../cubit/favorites_cubit/favorite_plans_cubit/favorite_plans_cubit.dart';
import '../../data/models/plan_model.dart';

class PlanListItem extends StatelessWidget {
  final PlanModel plan;

  const PlanListItem({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRouter.planMeals, arguments: plan.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, top: 8),
        height: 102,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: 94,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  plan.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16, bottom: 16, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plan.planName,
                      style: Theme.of(context).textTheme.headlineMedium,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      plan.description,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: AppColors.black.withOpacity(0.54),
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Starting from ${plan.startingPrice} AED',
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 16, top: 20),
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/arrow.svg'),
                  const Spacer(),
                  BlocBuilder<FavoritePlansCubit, FavoritePlansState>(
                    builder: (context, state) {
                      if (state is GetFavoritePlansSuccessState) {
                        if (state.favoritePlans.isNotEmpty &&
                            state.favoritePlans
                                .any((element) => element.id == plan.id)) {
                          return SvgPicture.asset(
                            'assets/icons/favorite-red-filled.svg',
                          );
                        } else {
                          return SvgPicture.asset(
                            'assets/icons/favorite-red.svg',
                          );
                        }
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
