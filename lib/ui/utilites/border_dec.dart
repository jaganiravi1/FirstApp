import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class CommonUtilites{

  static getInputDec(String hintText,IconData icon,String labeltxt){
    return InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManager.secondary,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        prefixIcon:
                            Icon(icon, color: ColorManager.secondary),
                        hintText: hintText,
                        //errorText: 'Invalid Email',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 2, color: ColorManager.secondary)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:  BorderSide(color: ColorManager.darkred)),

                        labelText: labeltxt,
                        labelStyle: TextStyle(color: ColorManager.secondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      );
  }

  
  static getPassInputDec(String hintText,IconData icon,String labeltxt, Function onLockedclick, {bool isLocked = true}){
    return InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock, color: ColorManager.secondary),
                      suffixIcon: InkWell(
                        child: Icon(
                            isLocked
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: ColorManager.secondary),
                        onTap: () {
                          onLockedclick();
                          // setState(() {
                          //   if (isShowPass) {
                          //     isShowPass = false;
                          //   } else {
                          //     isShowPass = true;
                          //   }
                          // });
                        },
                      ),
                      hintText: hintText,
                      //errorText: 'Invalid Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.secondary,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              width: 2, color: ColorManager.secondary)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              width: 2, color: ColorManager.secondary)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: ColorManager.darkred)),

                      labelText: labeltxt,
                      labelStyle: TextStyle(color: ColorManager.secondary),
                    );
  }

}