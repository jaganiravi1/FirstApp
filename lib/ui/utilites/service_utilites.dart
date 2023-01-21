import 'package:application/model/responses/language.dart';
import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:application/user_preferences/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/color_manager.dart';


class ServiceUtils {
  
  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: getRegularStyle(fontSize: 16.sp, color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade600,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  static showSuccessMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: getRegularStyle(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      duration: const Duration(seconds: 2),
    ));
  }

  // languageList for Localization
  static List<Language> languageList = [
    Language(
        name: 'English',
        langCode: 'en',
        image: IconAssets.ic_eng,
        isChecked: true),
    Language(
        name: 'Arabic',
        langCode: 'ar',
        image: IconAssets.ic_arb,
        isChecked: false)
  ];

  getHeaderWithBackArrowAndTitle(BuildContext context, String title,
      void Function() onBackClick, String lngCode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onBackClick,
          child: SizedBox(
            height: 21,
            width: 21,
            child: SvgPicture.asset(
              lngCode == LanguageCode.languageCodeArabic
                  ? IconAssets.backMirrorArrowBlack
                  : IconAssets.backArrowBlack,
              fit: BoxFit.fitHeight,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: getSemiBoldStyle(
              fontSize: 18, color: ColorManager.secondary),
        ),
      ],
    );
  }
}
