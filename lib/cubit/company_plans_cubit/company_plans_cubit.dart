import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/plan_model.dart';
import '../../data/repository/company_plans_repo.dart';
import '../../service/api_results.dart';

part 'company_plans_state.dart';

class CompanyPlansCubit extends Cubit<CompanyPlansState> {
  CompanyPlansCubit() : super(CompanyPlansInitialState());
  final CompanyPlansRepo repo = CompanyPlansRepo();

  Future<void> getCompanyPlans(String companyId) async {
    emit(GetCompanyPlansLoadingState());

    ApiResults<List<PlanModel>> result =
        await repo.getCompanyPlans(companyId: companyId);

    if (result is ApiSuccess<List<PlanModel>>) {
      Set<String> tags = {};
      for (var element in result.data!) {
        if (element.tag.isNotEmpty) {
          tags.add(element.tag);
        }
      }
      emit(GetCompanyPlansSuccessState(
          plans: result.data!, tags: tags.toList()));
    } else if (result is ApiFailure<List<PlanModel>>) {
      emit(GetCompanyPlansFailState(errorMsg: result.message));
    }
  }
}
