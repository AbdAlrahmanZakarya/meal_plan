import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_plan/data/models/company_model.dart';

import '../../service/api_results.dart';

class CompaniesRepo {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final List<CompanyModel> companies = [
    const CompanyModel(
      id: 'com1',
      companyName: 'Company1',
      description: 'company 1 description',
      startingPrice: '6500',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
      logoUrl: '',
      social: {},
    ),
    const CompanyModel(
      id: 'com2',
      companyName: 'Company2',
      description: 'company 2 description',
      startingPrice: '500',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle1.png?alt=media&token=17714483-b5d5-48d6-97f5-a9c94d774805',
      logoUrl: '',
      social: {},
    ),
    const CompanyModel(
      id: 'com3',
      companyName: 'Company3',
      description: 'company 3 description',
      startingPrice: '650',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle1.png?alt=media&token=17714483-b5d5-48d6-97f5-a9c94d774805',
      logoUrl: '',
      social: {},
    ),
    const CompanyModel(
      id: 'com4',
      companyName: 'Company4',
      description: 'company 4 description',
      startingPrice: '600',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
      logoUrl: '',
      social: {},
    ),
  ];

  Future<ApiResults<List<CompanyModel>>> getCompanies() async {
    try {
      List<CompanyModel> companies = [];
      var companiesDocs = await db.collection('companies').get();
      if (companiesDocs.docs.isNotEmpty) {
        for (var item in companiesDocs.docs) {
          companies.add(CompanyModel.fromMap(item.data(), item.id));
        }
      }

      return ApiSuccess(data: companies);
    } catch (e) {
      print(e);
      return ApiFailure(e.toString());
    }
  }

  addCompany() {
    try {
      for (CompanyModel element in companies) {
        db.collection('companies').add(element.toMap());
      }
    } catch (e) {
      print(e);
    }
  }
}
