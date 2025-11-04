part of 'company_plans_cubit.dart';

abstract class CompanyPlansState {}

class CompanyPlansInitialState extends CompanyPlansState {}

class GetCompanyPlansLoadingState extends CompanyPlansState {}

class GetCompanyPlansSuccessState extends CompanyPlansState {
  final List<PlanModel> plans;
  final List<String> tags;

  GetCompanyPlansSuccessState({required this.tags, required this.plans});
}

class GetCompanyPlansFailState extends CompanyPlansState {
  final String errorMsg;

  GetCompanyPlansFailState({required this.errorMsg});
}
