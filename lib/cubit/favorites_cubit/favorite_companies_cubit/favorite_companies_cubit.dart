import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/company_model.dart';
import '../../../data/repository/favorites_repo.dart';
import '../../../service/api_results.dart';

part 'favorite_companies_state.dart';

class FavoriteCompaniesCubit extends Cubit<FavoriteCompaniesState> {
  FavoriteCompaniesCubit() : super(FavoriteCompaniesInitialState());
  final FavoritesRepo repo = FavoritesRepo();

  Future<void> getFavoriteCompanies() async {
    try {
      emit(GetFavoriteCompaniesLoadingState());
      ApiResults<List<CompanyModel>> result = await repo.getFavoriteCompanies();

      if (result is ApiSuccess<List<CompanyModel>>) {
        // if (result.data!.isNotEmpty) {
        emit(GetFavoriteCompaniesSuccessState(favoriteCompanies: result.data!));
        // } else {
        //   emit(NoFavoriteCompaniesState());
        // }
      } else if (result is ApiFailure<List<CompanyModel>>) {
        print('error Message:  ${result.message}');
        emit(GetFavoriteCompaniesFailState(errorMessage: result.message));
      }
    } catch (e) {
      print('Catch Error: $e');
      emit(GetFavoriteCompaniesFailState(errorMessage: e.toString()));
    }
  }
}
