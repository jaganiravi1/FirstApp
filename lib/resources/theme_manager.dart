import 'package:application/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'fonts_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    //color of the app
    primaryColor: ColorManager.primary,
    

    //App Bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16
    
    ),
    textTheme: TextTheme(
        headline1: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headline2: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
        caption: getRegularStyle(color: ColorManager.grey),
        bodyText1: getRegularStyle(color: ColorManager.grey),

  ),

  ));
}