import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import '../../service/api_results.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository authRepo = AuthRepository();

  Future<void> register({
    required String email,
    required String password,
    required String gender,
    required DateTime? birthday,
    required String phone,
    required String? dialCode,
  }) async {
    try {
      emit(AuthLoadingState());
      ApiResults authResult = await authRepo.register(
        email: email,
        password: password,
        gender: gender,
        birthday: birthday,
        phone: phone,
        dialCode: dialCode,
      );
      if (authResult is ApiSuccess) {
        // sharedPrefs.setString('token', authResult.data['idToken']);
        // sharedPrefs.setString('userId', authResult.data['localId']);
        emit(AuthSuccessState());
      } else if (authResult is ApiFailure) {
        emit(AuthFailState(errorMessage: authResult.message));
      }
    } catch (e) {
      emit(AuthFailState(errorMessage: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    // try {
      emit(AuthLoadingState());
      ApiResults authResult =
          await authRepo.login(email: email, password: password);
      if (authResult is ApiSuccess) {
        // sharedPrefs.setString('token', authResult.data['idToken']);
        // sharedPrefs.setString('userId', authResult.data['localId']);

        emit(AuthSuccessState());
      } else if (authResult is ApiFailure) {
        emit(AuthFailState(errorMessage: authResult.message));
      }
    // } catch (e) {
    //   emit(AuthFailState(errorMessage: e.toString()));
    // }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoadingState());
      ApiResults authResult = await authRepo.signInWithGoogle();

      if (authResult is ApiSuccess) {
        // TODO: check if it is a new user or not, and add its data to firestore if it is a new user.

        // sharedPrefs.setString('token', authResult.data['idToken']);
        // sharedPrefs.setString('userId', authResult.data['localId']);
        emit(AuthSuccessState());
      } else if (authResult is ApiFailure) {
        emit(AuthFailState(errorMessage: authResult.message));
      }
    } catch (e) {
      emit(AuthFailState(errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(SignOutLoadingState());
      ApiResults signOutResult = await authRepo.signOut();
      if (signOutResult is ApiSuccess) {
        emit(SignOutSuccessState());
      } else if (signOutResult is ApiFailure) {
        emit(SignOutFailState(errorMessage: signOutResult.message));
      }
    } catch (e) {
      emit(SignOutFailState(errorMessage: e.toString()));
    }
  }

// void resetPassword(String email) async {
//   try {
//     emit(ResetPasswordLoadingState());
//     ApiResults authResult = await AuthRepository.sendResetEmailRepo(email);
//     if (authResult is ApiSuccess) {
//       emit(ResetPasswordSuccessState(email: authResult.data['email']));
//     } else if (authResult is ApiFailure) {
//       emit(ResetPasswordFailState(errorMessage: authResult.message));
//     }
//   } catch (e) {
//     emit(ResetPasswordFailState(errorMessage: e.toString()));
//   }
// }
}
