import 'package:application/l10n/localization.dart';
import 'package:application/model/responses/language.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:application/services/local_provider.dart';
import 'package:application/ui/screens/dashboard/dashboard.dart';
import 'package:application/ui/utilites/service_utilites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../user_preferences/user_preferences.dart';

class ChangeLanguage extends StatefulWidget {
  static String id = 'changeLang';
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
   String lngCode = '';
  @override
  void initState() {
    UserPreferences.getLocaleLanguageCode().then((value) => {
          setState(() {
            for (var element in ServiceUtils.languageList) {
              if (element.langCode == value) {
                element.isChecked = true;
              } else {
                element.isChecked = false;
              }
            }
            lngCode = value;
          })
        });
    super.initState();
  }

  Container saveLanguageButton({required void Function()? onPressed}) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(8.0)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          AppLocalizations.of(context)!.saveLanguage,
          style: getBoldStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSizedBoxSpacer(),
              ServiceUtils().getHeaderWithBackArrowAndTitle(
                  context, AppLocalizations.of(context)!.selectLanguage, () {
                Navigator.pop(context);
              }, lngCode),
              buildSizedBoxSpacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: ServiceUtils.languageList.length,
                  itemBuilder: (BuildContext context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: LanguageItem(
                      language: ServiceUtils.languageList[index],
                      onClick: () async {
                        setState(() {
                          for (var element in ServiceUtils.languageList) {
                            element.isChecked = false;
                          }
                          ServiceUtils.languageList[index].isChecked = true;
                          if (ServiceUtils.languageList[index].isChecked =
                              true) {
                            selectedIndex = index;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Consumer<LocaleProvider>(
                builder: (context, localeModel, child) =>
                    saveLanguageButton(onPressed: () {
                  setState(() {
                    localeModel.setLocale(Locale(
                        ServiceUtils.languageList[selectedIndex].langCode));
                    UserPreferences.setLocaleLanguageCode(
                        languageCode:
                            ServiceUtils.languageList[selectedIndex].langCode);
                  });
                  Navigator.pushNamedAndRemoveUntil(
                      context, Dashboard.id, (route) => false);
                }),
              ),
              buildSizedBoxSpacer()
            ],
          ),
        ),
      ),
    );
  }
}


class LanguageItem extends StatelessWidget {
  Language language;
  Function onClick;

  LanguageItem({Key? key, required this.language, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 28,
        ),
        height: 55,
        decoration: BoxDecoration(
          color: language.isChecked ? ColorManager.primary : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 18,
              width: 30,
              child: Image.asset(
                language.image,
                filterQuality: FilterQuality.high,
              ),
            ),
            buildSizedBoxSpacer(),
            Text(
              language.name,
              style: getSemiBoldStyle(
                  color: language.isChecked ? ColorManager.white : Colors.black,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox buildSizedBoxSpacer() {
  return SizedBox(
    height: 15,
    width: 15,
  );
}