import 'package:flutter/material.dart';
import 'package:meal_plan/data/models/meal_model.dart';

import '../../core/theme/colors.dart';
import '../company_profile_screen/widgets/custom_icon_button.dart';

class MealDetailsScreen extends StatelessWidget {
  final MealModel meal;

  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomCompanyInfoBar(companyId: meal),
      body: NestedScrollView(
        headerSliverBuilder: (ctx, _) {
          return [
            buildSliverAppBar(context),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
              child: Text(
                meal.mealName,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                meal.description,
                style: Theme.of(context).textTheme.displayLarge!,
              ),
            ),
            const SizedBox(height: 27),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              color: const Color(0xFFE2E4ED),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildColumn(
                    context: context,
                    quantity: meal.calorie,
                    quantityUnit: 'Kcal',
                  ),
                  buildColumn(
                    context: context,
                    quantity: meal.weight,
                    quantityUnit: 'gram',
                  ),
                  buildColumn(
                    context: context,
                    quantity: meal.protein,
                    quantityUnit: 'Protein',
                  ),
                  buildColumn(
                    context: context,
                    quantity: meal.carb,
                    quantityUnit: 'Carb',
                  ),
                  buildColumn(
                    context: context,
                    quantity: meal.fat,
                    quantityUnit: 'Fat',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 68,
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  buildTagItem(context: context, text: meal.tag),
                  buildTagItem(context: context, text: meal.kind),
                  buildTagItem(context: context, text: meal.companyName),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const Spacer(),
                Text(
                  '${meal.ingredients.length} items',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            ...meal.ingredients.map(
              (Ingredients e) => buildIngredientItem(
                context: context,
                ingredient: e,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center buildTagItem({
    required BuildContext context,
    required String text,
  }) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.08),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }

  Widget buildIngredientItem(
      {required BuildContext context, required Ingredients ingredient}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Row(
        children: [
          Image.network(
            ingredient.imageUrl,
            width: 28,
            height: 26,
          ),
          const SizedBox(width: 8),
          Text(
            ingredient.ingredientName,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.gray,
                ),
          ),
          const Spacer(),
          Text(
            '${ingredient.quantity} ${ingredient.quantityUnit}',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray,
                ),
          ),
        ],
      ),
    );
  }

  Column buildColumn({
    required BuildContext context,
    required String quantity,
    required String quantityUnit,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          quantity,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          quantityUnit,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      expandedHeight: 296,
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
      flexibleSpace: buildAppBar(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return FlexibleSpaceBar(
      // collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            // child: Hero(
            //   tag: company.id,
            child: Image.network(
              meal.imageUrl,
              fit: BoxFit.cover,
            ),
            // ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
