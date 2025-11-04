import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_plan/view/shared_widget/filter_sorting_buttons.dart';

import '../../core/theme/colors.dart';
import '../../cubit/companies_cubit/companies_cubit.dart';
import 'widgets/company_grid_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('dashboard initState');
    super.initState();
    context.read<CompaniesCubit>().getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<CompaniesCubit>().getCompanies();
      },
      child: CustomScrollView(
        slivers: [
          // ------------------------------ Header -----------------------------
          SliverPadding(
            padding: const EdgeInsets.only(top: 54, right: 16, left: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  // -------------------------- Header ---------------------------
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //-------------------- Header Title ------------------------
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                const TextSpan(
                                  text: 'Up to 30',
                                  style: TextStyle(color: AppColors.green),
                                ),
                                TextSpan(
                                  text: ' Meal Plan Company For your.',
                                  style: TextStyle(
                                    color: AppColors.black.withOpacity(0.64),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // ----------------- Header Search Icon ------------------
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset('assets/icons/search.svg'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  // --------------- Filters And Sorting Buttons ---------------
                  const FilterSortingButtons(),
                  // Row(
                  //   children: [
                  //     buildButtons(
                  //       text: 'Filter',
                  //       image: 'flame white',
                  //       backgroundColor: AppColors.primaryColor,
                  //       textColor: AppColors.white,
                  //     ),
                  //     const SizedBox(
                  //       width: 23,
                  //     ),
                  //     buildButtons(
                  //       text: 'Sorting',
                  //       image: 'sort',
                  //       backgroundColor:
                  //           AppColors.primaryColor.withOpacity(0.16),
                  //       textColor: AppColors.primaryColor,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 18),
                  // -------------------------- Divider ------------------------
                  Container(
                    color: AppColors.gray.withOpacity(0.12),
                    width: double.infinity,
                    height: 1,
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
          // ----------------------- Companies GridView ------------------------
          SliverPadding(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
            sliver: BlocBuilder<CompaniesCubit, CompaniesState>(
              builder: (context, state) {
                if (state is GetCompaniesLoadingState) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Loading...'),
                    ),
                  );
                }
                if (state is GetCompaniesSuccessState) {
                  return CompanyGridView(companies: state.companies);
                }

                return const SliverFillRemaining(
                  child: Center(
                    child: Text('Hello'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildButtons({
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

// SafeArea buildSafeArea(BuildContext context) {
//   return SafeArea(
//     child: SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Dashboard',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 8),
//                   RichText(
//                     text: TextSpan(
//                       style: Theme.of(context).textTheme.bodySmall,
//                       children: [
//                         const TextSpan(
//                           text: 'Up to 30',
//                           style: TextStyle(color: AppColors.green),
//                         ),
//                         TextSpan(
//                           text: ' Meal Plan Company For your',
//                           style: TextStyle(
//                             color: AppColors.black.withOpacity(0.64),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: 48,
//                   height: 48,
//                   decoration: const BoxDecoration(
//                     color: AppColors.green,
//                     shape: BoxShape.circle,
//                   ),
//                   child: SvgPicture.asset('assets/icons/search.svg'),
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               buildButtons(
//                 context: context,
//                 text: 'Filter',
//                 image: 'flame white',
//                 backgroundColor: AppColors.primaryColor,
//                 textColor: AppColors.white,
//               ),
//               const SizedBox(
//                 width: 16,
//               ),
//               buildButtons(
//                 context: context,
//                 text: 'Sorting',
//                 image: 'sort',
//                 backgroundColor: AppColors.primaryColor.withOpacity(0.16),
//                 textColor: AppColors.primaryColor,
//               ),
//             ],
//           ),
//           const SizedBox(height: 18),
//           Container(
//             color: AppColors.gray.withOpacity(0.12),
//             width: double.infinity,
//             height: 1,
//           ),
//           const SizedBox(height: 18),
//           GridView.builder(
//             itemCount: 12,
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 175,
//               mainAxisSpacing: 18,
//               crossAxisSpacing: 18,
//               childAspectRatio: 3 / 4,
//             ),
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (BuildContext context, int index) {
//               print(index);
//               return Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: Image.asset(
//                           'assets/temp/Rectangle${index % 2}.png',
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Flexible(
//                                 child: Text(
//                                   'Cook Smart Company',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displayMedium,
//                                   overflow: TextOverflow.fade,
//                                   softWrap: false,
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               SvgPicture.asset(
//                                 'assets/icons/company check white.svg',
//                                 height: 12,
//                                 width: 12,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Container(
//                                 width: 4,
//                                 height: 4,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: AppColors.black,
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 '+32 plans, fresh...',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .displaySmall!
//                                     .copyWith(
//                                       color:
//                                           AppColors.black.withOpacity(0.54),
//                                     ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               RichText(
//                                 text: TextSpan(
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displaySmall,
//                                   children: const [
//                                     TextSpan(
//                                       text: 'Starting from ',
//                                     ),
//                                     TextSpan(
//                                       text: '650',
//                                       style: TextStyle(
//                                           color: AppColors.primaryColor,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     TextSpan(
//                                       text: ' AED',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               SvgPicture.asset('assets/icons/arrow.svg'),
//                               const SizedBox(width: 8),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
