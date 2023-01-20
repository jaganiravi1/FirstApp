
import 'package:application/resources/color_manager.dart';
import 'package:flutter/material.dart';
class CommonButtonTheme {
  static Widget getCircularButton(
      Color buttonClr, context, String txt, Function() onTap) {
    return MaterialButton(
        height: 40,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        onPressed: onTap,
        color: buttonClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        //child: Text(txt,style: getMediumStyle(color: ColorManager.white,fontSize: 16),),
        child: Text(
          txt,
          style:  TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold),
        ));
  }
}
