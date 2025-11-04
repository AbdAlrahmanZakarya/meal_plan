part of 'plan_meals_cubit.dart';

abstract class PlanMealsState {}

class PlanMealsInitialState extends PlanMealsState {}

class GetPlanMealsLoadingState extends PlanMealsState {}

class GetPlanMealsSuccessState extends PlanMealsState {
  final List<MealModel> meals;
  final List<String> kinds;

  GetPlanMealsSuccessState({required this.kinds, required this.meals});
}

class GetPlanMealsFailState extends PlanMealsState {
  final String errorMsg;

  GetPlanMealsFailState({required this.errorMsg});
}
