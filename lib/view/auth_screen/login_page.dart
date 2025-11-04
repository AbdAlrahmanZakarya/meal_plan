import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_plan/core/theme/colors.dart';
import 'package:meal_plan/cubit/auth_cubit/auth_cubit.dart';

import 'widgets/auth_button.dart';
import 'widgets/auth_description_text.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/auth_title_text.dart';
import 'widgets/oauth_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signinOnPressed() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthCubit>().login(
          email: emailController.text,
          password: passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthTitleText(text: 'Login to your account'),
                  const SizedBox(height: 8),
                  const AuthDescriptionText(text: 'Login to continue.'),
                  const SizedBox(height: 24),
                  OAuthButton(
                    text: 'Login with Apple',
                    icon: 'assets/icons/apple.svg',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 24),
                  OAuthButton(
                    text: 'Login with Google',
                    icon: 'assets/icons/google.svg',
                    onPressed: () {
                      context.read<AuthCubit>().signInWithGoogle();
                    },
                    isGoogleBtn: true,
                  ),
                  const SizedBox(height: 28),
                  buildDivider(context),
                  const SizedBox(height: 34),
                  AuthTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'Phone or email',
                    prefixIcon: 'assets/icons/profile.svg',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter Your Email Or Phone.';
                      }
                      if (val.length < 5 ||
                          !val.contains('@') ||
                          !val.contains('.')) {
                        return 'Please Enter a Valid Email.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  AuthTextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter Your Password.';
                      }
                      if (val.length < 8) {
                        return 'Password must be more than 7 chars';
                      }
                      return null;
                    },
                    hint: 'Password',
                    prefixIcon: 'assets/icons/password.svg',
                    isPasswordField: true,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forget Password?'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        AuthButton(
          text: 'Login',
          onPressed: signinOnPressed,
        ),
      ],
    );
  }

  Widget buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            height: 1,
            color: AppColors.black.withOpacity(0.24),
          ),
        ),
        Text(
          'Or Login with',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            height: 1,
            color: AppColors.black.withOpacity(0.24),
          ),
        ),
      ],
    );
  }
}
