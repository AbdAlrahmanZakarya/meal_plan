import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:meal_plan/cubit/auth_cubit/auth_cubit.dart';

import '../../core/static_data.dart';
import '../../core/theme/colors.dart';
import 'widgets/auth_button.dart';
import 'widgets/auth_description_text.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/auth_title_text.dart';
import 'widgets/choose_gender_widget.dart';
import 'widgets/countries_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController =
      TextEditingController(text: '🇦🇪  +971');

  String countryDialCode = '+971';
  bool switchVal = false;
  DateTime? selectedDate;

  String gender = 'Male';

  signupOnPressed() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().register(
          email: emailController.text,
          password: passwordController.text,
          gender: gender,
          phone: phoneController.text,
          dialCode: countryDialCode,
          birthday: selectedDate,
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    birthdayController.dispose();
    countryController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void showCountryDialog() {
    showDialog(
      context: context,
      builder: ((context) {
        return CountriesDialog(countries: StaticData.countries);
      }),
    ).then((value) {
      setState(() {
        if (value is Map<String, String>) {
          countryController.text = '${value['flag']}  ${value['dial_code']}';
          countryDialCode = value['dial_code']!;
        }
      });
    });
  }

  showBirthdayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((DateTime? value) {
      if (value != null) {
        setState(() {
          birthdayController.text = DateFormat('yyyy/MM/dd').format(value);
          selectedDate = value;
        });
      }
    });
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
                  const AuthTitleText(text: 'Create an account'),
                  const SizedBox(height: 8),
                  const AuthDescriptionText(
                    text: 'Please fill the input below to register.',
                  ),
                  const SizedBox(height: 32),
                  AuthTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hint: 'Email',
                    prefixIcon: 'assets/icons/email.svg',
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
                  buildPhoneField(context),
                  const SizedBox(height: 24),
                  AuthTextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    hint: 'Password',
                    prefixIcon: 'assets/icons/password.svg',
                    isPasswordField: true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter Your Password.';
                      }
                      if (val.length < 8) {
                        return 'Password must be more than 7 chars';
                      }

                      var regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#$&*~]).{8,}$');
                      if (!regex.hasMatch(val)) {
                        return "Password Should Contain Upper, Lower, Digit And Special Character ";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  AuthTextField(
                    controller: birthdayController,
                    hint: 'Birth Date',
                    prefixIcon: 'assets/icons/calendar.svg',
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: showBirthdayDatePicker,
                      icon: SvgPicture.asset('assets/icons/calendar_plus.svg'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ChooseGenderWidget(
                    onTap: (val) {
                      gender = val;
                    },
                  ),
                  const SizedBox(height: 32),
                  buildTermsSwitch(context)
                ],
              ),
            ),
          ),
        ),
        AuthButton(
          text: 'Create Account',
          onPressed: switchVal ? signupOnPressed : null,
        ),
      ],
    );
  }

  Row buildTermsSwitch(BuildContext context) {
    return Row(
      children: [
        Switch.adaptive(
          value: switchVal,
          onChanged: (val) {
            setState(() {
              switchVal = val;
            });
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.black,
                  ),
              children: [
                const TextSpan(text: 'I agree with '),
                TextSpan(
                  text: 'Terms and Condition',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' And\n'),
                TextSpan(
                  text: 'Privacy Policy.',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhoneField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              TextField(
                controller: countryController,
                readOnly: true,
                onTap: showCountryDialog,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 4,
                child: IconButton(
                  onPressed: showCountryDialog,
                  icon: SvgPicture.asset(
                    'assets/icons/arrow_down.svg',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: AuthTextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.labelLarge,
            hint: 'Phone',
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Optional     ',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
