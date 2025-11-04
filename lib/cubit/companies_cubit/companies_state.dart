part of 'companies_cubit.dart';

abstract class CompaniesState {}

class CompaniesInitialState extends CompaniesState {}

class GetCompaniesLoadingState extends CompaniesState {}

class GetCompaniesSuccessState extends CompaniesState {
  final List<CompanyModel> companies;

  GetCompaniesSuccessState({required this.companies});
}

class GetCompaniesFailState extends CompaniesState {
  final String errorMsg;

  GetCompaniesFailState({required this.errorMsg});
}
