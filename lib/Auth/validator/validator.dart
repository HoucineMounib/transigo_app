class AuthValidator {
  static String? isNameValid(String? text) {
    if (text != null && text.contains(RegExp(r"[A-Z][a-z]{3}"))) {
      return null;
    } else {
      return "Name is not valid";
    }
  }

  static String? isEmailValid(String? text) {
    if (text != null && text.contains("@") && text.contains(".")) {
      return null;
    } else {
      return "Email is wrong";
    }
  }

  static String? isPasswordValid(String? text) {
    if (text != null && text.length >= 8) {
      return null;
    } else {
      return "Password is not valid (the password need to be up 8)";
    }
  }
}
