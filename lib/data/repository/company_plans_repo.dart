import 'package:cloud_firestore/cloud_firestore.dart';

import '../../service/api_results.dart';
import '../models/plan_model.dart';

class CompanyPlansRepo {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<ApiResults<List<PlanModel>>> getCompanyPlans(
      {required String companyId}) async {
    try {
      List<PlanModel> plans = [];
      var companiesDocs = await db
          .collection('plans')
          .where('companyId', isEqualTo: companyId)
          .get();
      if (companiesDocs.docs.isNotEmpty) {
        for (var item in companiesDocs.docs) {
          plans.add(PlanModel.fromMap(item.data(), item.id));
        }
      }

      return ApiSuccess(data: plans);
    } catch (e) {
      print(e);
      return ApiFailure(e.toString());
    }
  }
}
