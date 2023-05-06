class ValidationRules {
  static String? email(String? text) {
    if (text == null || text.isEmpty) {
      return "please enter your email";
    } else if (!text.contains('@')) {
      return "please enter a valid email";
    } else {
      null;
    }
    return null;
  }

  static String? password(String? text) {
    if (text == null || text.isEmpty) {
      return "please enter password";
    } else if (text.length < 6) {
      return "please length should  be minimum 6";
    } else {
      null;
    }
    return null;
  }

  static String? phone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Please enter your phone number";
    } else if (phone.length != 11) {
      return "Number should be 11 di";
    } else if (phone.contains(RegExp(r'[A-Z]')) ||
        phone.contains(RegExp(r'[a-z]'))) {
      return "Only digit please";
    }
    return null;
  }

  static String? regularField(String? text) {
    if (text!.isEmpty) {
      return "You can't empty here";
    }
    return null;
  }
}