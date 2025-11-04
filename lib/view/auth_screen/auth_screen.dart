import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';
import '../../cubit/auth_cubit/auth_cubit.dart';
import '../../router.dart';
import '../shared_widget/sliding_segmented_control_widget.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  int groupValue = 0;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        color: AppColors.backgroundColor,
        width: 100.w > 500 ? 500 : 100.w,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            } else if (state is AuthSuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.home,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState || state is AuthSuccessState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding:   EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 16,
                      top: 18 + padding.top,
                    ),
                    child: SlidingSegmentedControlWidget(
                      tab1Text: 'Login',
                      tab2Text: 'Register',
                      onValueChanged: (int? val) {
                        if (val == 0) {
                          _controller.animateTo(0);
                        } else if (val == 1) {
                          _controller.animateTo(1);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _controller,
                      children: const [
                        LoginPage(),
                        RegisterPage(),
                      ],
                    ),
                  ),
                  SizedBox(height: padding.bottom ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
