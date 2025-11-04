import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/company_model.dart';
import '../../data/repository/companies_repo.dart';
import '../../service/api_results.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(CompaniesInitialState());
  final CompaniesRepo companiesRepo = CompaniesRepo();

  Future<void> getCompanies() async {
    emit(GetCompaniesLoadingState());
    ApiResults result = await companiesRepo.getCompanies();
    if (result is ApiSuccess) {
      emit(GetCompaniesSuccessState(companies: result.data));
    } else if (result is ApiFailure) {
      emit(GetCompaniesFailState(errorMsg: result.message));
    }
  }
}
