// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

// * Login States

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailState extends AuthState {
  String errorMessage;

  LoginFailState({required this.errorMessage});
}

// * Auth States

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthFailState extends AuthState {
  String errorMessage;

  AuthFailState({required this.errorMessage});
}

// * SignUp States

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailState extends AuthState {
  String errorMessage;

  SignUpFailState({required this.errorMessage});
}

// * ResetPassword States

class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {
  String email;
  ResetPasswordSuccessState({
    required this.email,
  });
}

class ResetPasswordFailState extends AuthState {
  String errorMessage;

  ResetPasswordFailState({required this.errorMessage});
}


class SignOutLoadingState extends AuthState {}

class SignOutSuccessState extends AuthState {}

class SignOutFailState extends AuthState {
  String errorMessage;

  SignOutFailState({required this.errorMessage});
}