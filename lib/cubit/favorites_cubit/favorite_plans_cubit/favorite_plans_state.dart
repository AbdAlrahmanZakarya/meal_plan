part of 'favorite_plans_cubit.dart';

abstract class FavoritePlansState {}

class FavoritePlansInitialState extends FavoritePlansState {}

class GetFavoritePlansSuccessState extends FavoritePlansState {
  final List<PlanModel> favoritePlans;
  final String? errorMsg;

  GetFavoritePlansSuccessState({
    required this.favoritePlans,
    this.errorMsg,
  });
}

class GetFavoritePlansFailState extends FavoritePlansState {
  final String errorMessage;

  GetFavoritePlansFailState({required this.errorMessage});
}

class GetFavoritePlansLoadingState extends FavoritePlansState {}
