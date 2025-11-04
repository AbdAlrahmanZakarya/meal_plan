import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_plan/data/models/userdata_model.dart';
import 'package:meal_plan/main.dart';

import '../../service/api_results.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<ApiResults> register({
    required String email,
    required String password,
    required String gender,
    required DateTime? birthday,
    required String phone,
    required String? dialCode,
  }) async {
    try {
      final userData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await prefs.setString('userId', userData.user!.uid);
      await prefs.setString('gender', gender);

      final Map<String, dynamic> data = {
        'gender': gender,
        'favoriteCompanies': [],
        'favoritePlans': [],
      };
      await prefs.setStringList('favoriteCompanies', []);
      await prefs.setStringList('favoritePlans', []);

      if (birthday != null) {
        await prefs.setString('birthday', birthday.toIso8601String());
        data['birthday'] = birthday.toIso8601String();
      }
      if (phone.isNotEmpty) {
        await prefs.setString('phone', phone);
        data['phone'] = phone;
        data['dialCode'] = dialCode;
      }

      await db.collection("users").doc(userData.user!.uid).set(data);

      return ApiSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ApiFailure('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ApiFailure('The account already exists for that email.');
      } else {
        return ApiFailure(e.code);
      }
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  Future<ApiResults> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      var userData =
          await db.collection('users').doc(credential.user!.uid).get();

      UserData user = UserData.fromMap(userData.data()!, credential.user!.uid);

      await user.saveToPrefs();

      // await prefs.setString('userId', credential.user!.uid);
      // await prefs.setString('gender', user.gender);
      // await prefs.setString('phone', user.phone ?? '');
      // await prefs.setString('birthday', user.birthday?.toIso8601String() ?? '');
      // await prefs.setStringList('favoriteCompanies', user.favoriteCompanies);
      // await prefs.setStringList('favoritePlans', user.favoritePlans);

      return ApiSuccess();
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     return ApiFailure('No user found for that email.');
      //   } else if (e.code == 'wrong-password') {
      //     return ApiFailure('Wrong password provided for that user.');
      //   } else {
      //     return ApiFailure(e.code);
      //   }
    } catch (e) {
      print(e);
      return ApiFailure(e.toString());
    }
  }

  Future<ApiResults> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
          // scopes: [
          //   'email',
          //   'https://www.googleapis.com/auth/user.gender.read',
          //   'https://www.googleapis.com/auth/user.birthday.read',
          // ],
          );
      print(00);

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      print(0);

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      print(1);
      // print('sign in with google:  ${await getGender(googleSignIn)}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(2);

      // UserCredential userData =
      await _firebaseAuth.signInWithCredential(credential);

      // if (userData.additionalUserInfo!.isNewUser) {
      //   var x = await db.collection('users').doc(userData.user!.uid).set({});
      // }

      // var doc = await db.collection('users').doc(userData.user!.uid).get();
      //
      // if(doc.exists){
      //   return ApiSuccess();
      // }
      // else{
      //   // googleUser.
      // }

      return ApiSuccess();
    } catch (e) {
      print(e);
      return ApiFailure(e.toString());
    }
  }

  Future<ApiResults> signOut() async {
    try {
      await prefs.clear();
      await GoogleSignIn().signOut();
      await _firebaseAuth.signOut();
      return ApiSuccess();
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  Future updateUserData(String userId) async {
    try {
      var userData = await db.collection('users').doc(userId).get();
      if (userData.exists) {
        UserData user = UserData.fromMap(userData.data()!, userId);
        await user.saveToPrefs();
      }
    } catch (e) {
      print(e);
    }
  }

// Future<String> getGender(GoogleSignIn googleSignIn) async {
//   try {
//     final headers = await googleSignIn.currentUser!.authHeaders;
//     final r = await http.get(
//         Uri.parse(
//             "https://people.googleapis.com/v1/people/me?personFields=genders,birthdays&key=AIzaSyAyvz-xIYBKFRGfYSa4P6QHt_nZEyHIKyM"),
//         headers: {"Authorization": headers["Authorization"]!});
//     final response = json.decode(r.body);
//     // print(response);
//     return response["genders"][0]["formattedValue"];
//   } catch (e) {
//     return e.toString();
//   }
// }
}
