import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_plan/data/models/company_model.dart';

import '../../main.dart';
import '../../service/api_results.dart';
import '../models/plan_model.dart';

class FavoritesRepo {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<ApiResults<List<PlanModel>>> getFavoritePlans() async {
    try {
      List<PlanModel> loadedItems = [];
      List<String> favoritePlansIDs =
          prefs.getStringList('favoritePlans') ?? <String>[];
      if (favoritePlansIDs.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> resultData = await db
            .collection('plans')
            .where(FieldPath.documentId, whereIn: favoritePlansIDs)
            .get();
        for (var element in resultData.docs) {
          loadedItems.add(PlanModel.fromMap(element.data(), element.id));
        }
      }

      // favoritePlans = loadedItems;
      return ApiSuccess(data: loadedItems);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  addPlanToFavorites(String planId) async {}

  deletePlanFromFavorites(String planId) async {
    // TODO: Remove from firebase and sharedPrefs.
    try {
      prefs.getString('userId');
      db.collection('users').doc(userId).update({
        'favoritePlans': FieldValue.arrayRemove([planId]),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResults<List<CompanyModel>>> getFavoriteCompanies() async {
    try {
      List<CompanyModel> loadedItems = [];
      List<String> favoriteCompaniesIDs =
          prefs.getStringList('favoriteCompanies') ?? [];
      if (favoriteCompaniesIDs.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> resultData = await db
            .collection('companies')
            .where(FieldPath.documentId, whereIn: favoriteCompaniesIDs)
            .get();
        for (var element in resultData.docs) {
          loadedItems.add(CompanyModel.fromMap(element.data(), element.id));
        }
      }
      print(loadedItems);
      return ApiSuccess(data: loadedItems);
    } catch (e) {
      print(e);
      return ApiFailure(e.toString());
    }
  }
}
