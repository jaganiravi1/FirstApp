enum UserTypes { loggedInAsGuest }

class GlobalVariables {
  static UserTypes userType = UserTypes.loggedInAsGuest;
  static String languageCode = LanguageCode.languageCodeArabic;
}


class LanguageCode {
  static const String languageCodeEnglish = "en";
  static const String languageCodeArabic = "ar";
}

