import 'package:flutter/material.dart';
import 'package:meal_plan/data/models/company_model.dart';

import '../../../core/theme/colors.dart';
import 'custom_icon_button.dart';

class CompanyProfileHeader extends StatelessWidget {
  final CompanyModel company;
  const CompanyProfileHeader({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      title: const Text(
        'myTitle',
        style: TextStyle(color: Colors.black),
      ),
      collapseMode: CollapseMode.pin,
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
              company.imageUrl,
              fit: BoxFit.cover,
            ),
            // ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Text(
                  '${company.companyName} Company',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.lightGray,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  company.description,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(
                    color: AppColors.lightGray,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CustomIconButton(
                      imageUrl: 'assets/icons/Instagram.svg',
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomIconButton(
                      imageUrl: 'assets/icons/twitter.svg',
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomIconButton(
                      imageUrl: 'assets/icons/Browser.svg',
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(),
                      child: Text(
                        'https://cook-smart.ae/',
                        style:
                        Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 64,
                  height: 1.5,
                  color: const Color(0x8F707070),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
