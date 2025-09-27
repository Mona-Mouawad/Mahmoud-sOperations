import 'package:flutter/services.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';



ThemeData getTheme() {
  return ThemeData(
    // main colors
    primaryColor: AppColors.primary,
    fontFamily: "Neo_Sans_Medium",
    primaryColorLight: AppColors.lightPrimary,
    primaryColorDark: AppColors.darkPrimary,
    disabledColor: AppColors.grey,
    splashColor: AppColors.lightPrimary,
    primarySwatch: Colors.grey ,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary,primary:  AppColors.primary,
      primaryContainer:  AppColors.primary, ),


    cardTheme: CardTheme(
      color: AppColors.white,
      shadowColor: AppColors.grey,
      elevation: AppSize.s4,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8,vertical: AppMargin.m0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s20)),
    ),

    // application bar theme
    appBarTheme: AppBarTheme(
      elevation: AppSize.s4,
      shadowColor: AppColors.lightPrimary,
      color: AppColors.lightPrimary,
      centerTitle: true,
      titleTextStyle: getBoldTextStyle(color: AppColors.black, fontSize: 18),
      systemOverlayStyle:   const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      iconTheme: IconThemeData(color: AppColors.black )
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      disabledColor: AppColors.grey,
      buttonColor: AppColors.primary,
      shape: const StadiumBorder(),
      splashColor: AppColors.lightPrimary,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(AppSize.s20)),
        textStyle: getBoldTextStyle( color: AppColors.white, fontSize: FontSize.s18),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      headlineLarge: getSemiBoldTextStyle(   color: AppColors.darkPrimary, fontSize: FontSize.s16),
      headlineMedium: getRegularTextStyle(color: AppColors.white, fontSize: FontSize.s18),
      displayLarge: getMediumTextStyle(  color: AppColors.primary, fontSize: FontSize.s14),
      titleMedium: getMediumTextStyle( color: AppColors.black, fontSize: FontSize.s14),
      bodyMedium: getRegularTextStyle(color: AppColors.error ,fontSize: FontSize.s22),
      bodySmall: getRegularTextStyle(color: AppColors.black ,fontSize: FontSize.s12),
      displayMedium: getSemiBoldTextStyle(color: AppColors.black ,fontSize: FontSize.s12),
    ),

// input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide:  BorderSide(color: AppColors.primary, width: AppSize.s1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1)),
      // error border style
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide:  BorderSide(color: AppColors.error, width: AppSize.s1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide:  BorderSide(color: AppColors.primary, width: AppSize.s1)),
// hint text Style
      errorStyle: getRegularTextStyle(color: AppColors.error),
      hintStyle:  getRegularTextStyle(color: AppColors.grey, fontSize: FontSize.s14),
      labelStyle: getMediumTextStyle(color: AppColors.grey, fontSize: FontSize.s14),
    ),

    bottomSheetTheme: BottomSheetThemeData(
        // elevation: AppSize.s1_5,
        backgroundColor: AppColors.white.withOpacity(0)),
  );
}
