import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_plan/router.dart';
import '../../../core/theme/colors.dart';
import '../../../data/models/company_model.dart';

class CompanyGridView extends StatelessWidget {
  final List<CompanyModel> companies;

  const CompanyGridView({Key? key, required this.companies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 175,
        mainAxisSpacing: 23,
        crossAxisSpacing: 24,
        childAspectRatio: 3 / 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CompanyGridItem(company: companies[index]);
        },
        childCount: companies.length,
      ),
    );
  }
}

class CompanyGridItem extends StatelessWidget {
  final CompanyModel company;

  const CompanyGridItem({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRouter.companyProfile, arguments: company);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                // child: Hero(
                //   tag: company.id,
                child: Image.network(
                  company.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          company.companyName,
                          style: Theme.of(context).textTheme.displayMedium,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/icons/company check white.svg',
                        height: 12,
                        width: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          company.description,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: AppColors.black.withOpacity(0.54),
                              ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.displaySmall,
                            children: [
                              const TextSpan(
                                text: 'Starting from ',
                              ),
                              TextSpan(
                                text: company.startingPrice,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: ' AED',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset('assets/icons/arrow.svg'),
                      const SizedBox(width: 8),
                    ],
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
