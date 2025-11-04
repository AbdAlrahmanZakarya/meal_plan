import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_plan/data/models/meal_model.dart';

import '../../service/api_results.dart';

class PlanMealsRepo {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<ApiResults<List<MealModel>>> getPlanMeals(
      {required String planId}) async {
    // try {
      List<MealModel> meals = [];
      var mealDoc = await db.collection('meals').doc(planId).get();
      if (mealDoc.data() != null && mealDoc.data()!['meals'] != null) {
        (mealDoc.data()!['meals'] as  Map<String, dynamic> )
            .forEach((key, value) {
          meals.add(MealModel.fromMap(value, mealId: key, planId: planId));
        });
      }

      return ApiSuccess(data: meals);
    // } catch (e) {
    //   print(e);
    //   return ApiFailure(e.toString());
    // }
  }
}
