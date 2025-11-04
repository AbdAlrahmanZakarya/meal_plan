import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_plan/cubit/favorites_cubit/favorite_plans_cubit/favorite_plans_cubit.dart';
import 'package:meal_plan/cubit/plan_meals_cubit/plan_meals_cubit.dart';
import 'package:meal_plan/data/models/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'cubit/auth_cubit/auth_cubit.dart';
import 'core/theme/themes.dart';
import 'cubit/companies_cubit/companies_cubit.dart';
import 'firebase_options.dart';
import 'router.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await CompaniesRepo().addCompany();
  // await x();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => FavoritePlansCubit(),
        ),
        BlocProvider(
          create: (ctx) => CompaniesCubit(),
        ),
        BlocProvider(
          create: (ctx) => PlanMealsCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

x() async {
  final db = FirebaseFirestore.instance;
  // var plan1 = const PlanModel(
  //     id: 'id 1',
  //     companyId: 'zMDIHqQbcPNCJ65dTot3',
  //     imageUrl:
  //         'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle1.png?alt=media&token=17714483-b5d5-48d6-97f5-a9c94d774805',
  //     planName: 'planName 1',
  //     description: 'description',
  //     startingPrice: '500',
  //     tag: '');
  // var plan2 = const PlanModel(
  //     id: 'id 2',
  //     companyId: 'zMDIHqQbcPNCJ65dTot3',
  //     imageUrl:
  //         'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
  //     planName: 'planName 2',
  //     description: 'description',
  //     startingPrice: '500',
  //     tag: '');
  // db.collection('plans').add(plan1.toMap());
  var meal = MealModel(
    mealId: 'random id 1',
    planId: '1wbEPcVWKUu9jZ65FT9k',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
    companyName: 'company 1 Name',
    carb: '123',
    mealName: 'mealName 2',
    protein: '21',
    calorie: '345',
    fat: '445',
    weight: '100',
    tag: 'Weight Loos',
    kind: 'Launch',
    ingredients: const [
      Ingredients(
        quantity: '22',
        ingredientName: 'test',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/fitme-app-55303.appspot.com/o/Companies%20Images%2FRectangle0.png?alt=media&token=b88c6c18-7bcc-4d25-96e9-2eaec7a86102',
        quantityUnit: 'pc',
      ),
    ],
    description: '',
  );

  await db.collection('meals').doc(meal.planId).set(
    {
      'meals': {meal.mealId: meal.toMap()}
    },
    SetOptions(merge: true),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    // print(user);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Meal Plan',
          debugShowCheckedModeBanner: false,
          theme: Themes.lightTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: user == null ? AppRouter.auth : AppRouter.home,
          // home:
          //     const HomeScreen(), //user == null ? const AuthScreen() : const HomeScreen(),
        );
      },
    );
  }
}
