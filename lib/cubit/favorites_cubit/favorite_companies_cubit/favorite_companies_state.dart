part of 'favorite_companies_cubit.dart';

abstract class FavoriteCompaniesState {}

class FavoriteCompaniesInitialState extends FavoriteCompaniesState {}

class GetFavoriteCompaniesSuccessState extends FavoriteCompaniesState {
  final List<CompanyModel> favoriteCompanies;

  GetFavoriteCompaniesSuccessState({required this.favoriteCompanies});
}

class GetFavoriteCompaniesFailState extends FavoriteCompaniesState {
  final String errorMessage;

  GetFavoriteCompaniesFailState({required this.errorMessage});
}

class GetFavoriteCompaniesLoadingState extends FavoriteCompaniesState {}

class NoFavoriteCompaniesState extends FavoriteCompaniesState {}
