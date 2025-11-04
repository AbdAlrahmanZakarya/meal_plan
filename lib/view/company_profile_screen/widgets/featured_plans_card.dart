import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/colors.dart';

class FeaturesPlansCard extends StatelessWidget {
  const FeaturesPlansCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 297,
        height: 340,
        padding: const EdgeInsets.only(
          right: 8,
          left: 24,
          top: 24,
        ),
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: AppColors.green.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breakfast + Lunch + Dinner',
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 18,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,

                      ),
                      // const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'AED',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            '1590',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          Text(
                            '00',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
                  ),
                  radius: 50,
                ),
              ],
            ),
            Text(
              'What included:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            for (var i = 0; i < 3; i++)
              Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      height: 40,
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, right: 10, left: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/check.svg',
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'easy and delicious meals',
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              // maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (i == 2)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 45,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
