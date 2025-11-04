import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/meal_model.dart';
import '../../data/repository/plan_meals_repo.dart';
import '../../service/api_results.dart';

part 'plan_meals_state.dart';

class PlanMealsCubit extends Cubit<PlanMealsState> {
  PlanMealsCubit() : super(PlanMealsInitialState());
  PlanMealsRepo mealsRepo = PlanMealsRepo();

  Future<void> getCompanyPlans(String planId) async {
    // try {
      emit(GetPlanMealsLoadingState());
      ApiResults<List<MealModel>> result =
          await mealsRepo.getPlanMeals(planId: planId);

      if (result is ApiSuccess<List<MealModel>>) {
        Set<String> kinds = {};
        for (var element in result.data!) {
          if (element.kind.isNotEmpty) {
            kinds.add(element.kind);
          }
        }
        emit(GetPlanMealsSuccessState(
            meals: result.data!, kinds: kinds.toList()));
      } else if (result is ApiFailure<List<MealModel>>) {
        emit(GetPlanMealsFailState(errorMsg: result.message));
      }
    // } catch (e) {
    //   emit(GetPlanMealsFailState(errorMsg: e.toString()));
    // }
  }
}
