import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_plan/cubit/companies_cubit/companies_cubit.dart';

import '../../core/theme/colors.dart';
import '../../data/models/company_model.dart';
import '../company_profile_screen/widgets/custom_icon_button.dart';

class BottomCompanyInfoBar extends StatelessWidget {
  final String companyId;

  const BottomCompanyInfoBar({Key? key, required this.companyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 32),
      height: 88,
      color: AppColors.white,
      width: double.infinity,
      child: Center(
        child: BlocBuilder<CompaniesCubit, CompaniesState>(
          builder: (context, state) {
            if (state is GetCompaniesSuccessState) {
              CompanyModel company = state.companies
                  .firstWhere((element) => element.id == companyId);
              return SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Image.network(
                      company.logoUrl,
                      width: 50,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  company.companyName,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const SizedBox(width: 6),
                              SvgPicture.asset(
                                'assets/icons/company check blue.svg',
                                width: 10,
                                height: 10,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            company.description,
                            style: Theme.of(context).textTheme.headlineSmall,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    CustomIconButton(
                      imageUrl: 'assets/icons/call.svg',
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    CustomIconButton(
                      imageUrl: 'assets/icons/whatsapp.svg',
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }
            return const Center();
          },
        ),
      ),
    );
  }
}
