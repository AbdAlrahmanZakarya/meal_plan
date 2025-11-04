import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_plan/data/models/meal_model.dart';
import 'package:meal_plan/view/meal_details_screen/meal_details_screem.dart';
import 'package:meal_plan/view/plan_meals_screen/plan_meals_screen.dart';

import 'cubit/company_plans_cubit/company_plans_cubit.dart';
import 'cubit/favorites_cubit/favorite_companies_cubit/favorite_companies_cubit.dart';
import 'data/models/company_model.dart';
import 'view/auth_screen/auth_screen.dart';
import 'view/company_profile_screen/company_profile_screen.dart';
import 'view/home_screen/home_screen.dart';
import 'view/onboarding_screen/onboarding_screen.dart';

class AppRouter {
  static const String onboarding = 'onboarding';
  static const String auth = 'auth';
  static const String home = 'home';
  static const String companyProfile = 'companyProfile';
  static const String planMeals = 'planMeals';
  static const String mealDetails = 'mealDetails';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(
          builder: (ctx) => const OnBoardingScreen(),
        );
      case auth:
        return MaterialPageRoute(
          builder: (ctx) => const AuthScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (ctx) => MultiBlocProvider(
            providers: [
              // BlocProvider(
              //   create: (ctx) => CompaniesCubit(),
              // ),
              // BlocProvider(
              //   create: (ctx) => FavoritePlansCubit(),
              // ),
              BlocProvider(
                create: (ctx) => FavoriteCompaniesCubit(),
              ),
            ],
            child: const HomeScreen(),
          ),

          // BlocProvider(
          //   create: (context) => DashboardCubit(),
          //   child:   HomeScreen(),
          // ),
        );
      case companyProfile:
        CompanyModel company = settings.arguments as CompanyModel;
        return MaterialPageRoute(
          builder: (ctx) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (ctx) => CompanyPlansCubit(),
              ),
            ],
            child: CompanyProfileScreen(
              company: company,
            ),
          ),
        );
      case planMeals:
        String planId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (ctx) => PlanMealsScreen(planId: planId),
        );
      case mealDetails:
        MealModel meal = settings.arguments as MealModel;
        return MaterialPageRoute(
          builder: (ctx) => MealDetailsScreen(meal: meal),
        );
    }
    return null;
  }
}
