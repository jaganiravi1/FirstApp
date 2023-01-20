import 'package:application/resources/string_manager.dart';

class Validation {
  static String? getEmailCondition(String? value) {
    if (value!.isEmpty) {
      return StringManager.required;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return StringManager.validEmail;
    }
    return null;
  }

  static String? getPassCondition(String? value) {
    if (value!.isEmpty) {
      return StringManager.required;
    }
    if (value.length <= 6) {
      return StringManager.passwordCondition;
    }
    return null;
  }

  static String? getConfirmPassCondition(String? value, String passController) {
    if (value!.isEmpty) {
      return StringManager.required;
    }

    if (value != passController) {
      return StringManager.passwordNotMatch;
    }
    return null;
  }
}
