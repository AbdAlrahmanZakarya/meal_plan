import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/colors.dart';

class FilterSortingButtons extends StatelessWidget {
  const FilterSortingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildButtons(
          context: context,
          text: 'Filter',
          image: 'flame white',
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.white,
        ),
        const SizedBox(
          width: 23,
        ),
        buildButtons(
          context: context,
          text: 'Sorting',
          image: 'sort',
          backgroundColor: AppColors.primaryColor.withOpacity(0.16),
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget buildButtons({
    required BuildContext context,
    required Color backgroundColor,
    required Color textColor,
    required String image,
    required String text,
  }) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: 1.5,
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/$image.svg'), //flame white
            const SizedBox(width: 8),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: textColor), //AppColors.white
            ),
          ],
        ),
      ),
    );
  }
}
