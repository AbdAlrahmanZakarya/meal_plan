import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
    canvasColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: 'Raleway',
    brightness: Brightness.light,
    textTheme: _textTheme,
    // appBarTheme: const AppBarTheme(
    //   foregroundColor: AppColors.black,
    //   elevation: 0,
    //   color: AppColors.white,
    //   centerTitle: true,
    //   titleTextStyle: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.black,
    //   ),
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            fontFamily: 'Raleway',
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      fillColor: AppColors.white,
      filled: true,
      hintStyle: _textTheme.bodyLarge,
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     padding: MaterialStateProperty.all(EdgeInsets.zero),
    //     foregroundColor: MaterialStateProperty.all(AppColors.primaryColor),
    //   ),
    // ),
  );

  static const TextTheme _textTheme = TextTheme(
    // ! Titles
    titleLarge: TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 22, //18.sp
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Merriweather',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),

    // ! headline
    headlineLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
      fontFamily: 'Raleway',
    ),

    headlineMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
      fontFamily: 'Raleway',
    ),
    headlineSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: AppColors.gray,
      fontFamily: 'Raleway',
    ),

    // ! body
    bodyLarge: TextStyle(
      fontSize: 16, //12.3.sp
      fontWeight: FontWeight.w600,
      color: AppColors.gray,
      fontFamily: 'Raleway',
    ),
    bodyMedium: TextStyle(
      fontSize: 16, // 12.3.sp
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: 'Raleway',
    ),
    bodySmall: TextStyle(
      fontSize: 14, // 10.6.sp
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      fontFamily: 'Raleway',
    ),

    // display
    displayLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.gray,
      fontFamily: 'Raleway',
    ),
    displayMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
      fontFamily: 'Raleway',
    ),

    displaySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: 'Raleway',
    ),

    // displaySmall: TextStyle(
    //   fontSize: 10,
    //   fontWeight: FontWeight.w600,
    //   color: AppColors.primaryColor,
    //   fontFamily: 'Raleway',
    // ),

    // ! label
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontFamily: 'Roboto',
    ),

    // TextStyle(
    //   fontSize: 14,
    //   fontWeight: FontWeight.w600,
    //   color: AppColors.lightBlack,
    // ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      color: AppColors.white,
      decoration: TextDecoration.underline,
    ),
  );
}
