import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/plan_model.dart';
import '../../../data/repository/favorites_repo.dart';
import '../../../service/api_results.dart';

part 'favorite_plans_state.dart';

class FavoritePlansCubit extends Cubit<FavoritePlansState> {
  FavoritePlansCubit() : super(FavoritePlansInitialState());
  final FavoritesRepo repo = FavoritesRepo();
  List<PlanModel> favoritePlans = [];

  Future<void> getFavoritePlans() async {
    try {
      emit(GetFavoritePlansLoadingState());
      ApiResults<List<PlanModel>> result = await repo.getFavoritePlans();

      if (result is ApiSuccess<List<PlanModel>>) {
        // if (result.data!.isNotEmpty) {
        favoritePlans = result.data!;
        emit(GetFavoritePlansSuccessState(favoritePlans: favoritePlans));
        // } else {
        //   emit(NoFavoritePlansState());
        // }
      } else if (result is ApiFailure<List<PlanModel>>) {
        print('error Message:  ${result.message}');
        emit(GetFavoritePlansFailState(errorMessage: result.message));
      }
    } catch (e) {
      print('Catch Error: $e');
      emit(GetFavoritePlansFailState(errorMessage: e.toString()));
    }
  }

  Future<void> switchPlanFavoriteStatus(PlanModel plan) async {
    String? errorMsg;

    if (favoritePlans.any((element) => element.id == plan.id)) {
      var result = await repo.deletePlanFromFavorites(plan.id);
      if (result is ApiSuccess) {
        favoritePlans.removeWhere((element) => element.id == plan.id);
      } else if (result is ApiFailure) {
        errorMsg = result.message;
      }
    } else {
      var result = repo.addPlanToFavorites(plan.id);
      if (result is ApiSuccess) {
        favoritePlans.add(plan);
      } else if (result is ApiFailure) {
        errorMsg = result.message;
      }
    }
    emit(
      GetFavoritePlansSuccessState(
        favoritePlans: favoritePlans,
        errorMsg: errorMsg,
      ),
    );
  }
}
