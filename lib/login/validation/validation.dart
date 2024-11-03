//validation for user name
class NameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }
    if (value.startsWith(' ')) {
      return 'Name cannot start with a space';
    }
    RegExp regExp = RegExp(r"^[A-Za-z][A-Za-z ]*$");
    if (!regExp.hasMatch(value)) {
      return 'Name must only contain letters and spaces';
    }
    int letterCount = value.replaceAll(RegExp(r'[^A-Za-z]'), '').length;
    if (letterCount < 4) {
      return 'Name must contain at least 4 letters';
    }
    return null;
  }
}
//validation for user phone
class PhoneNumberValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length != 10) {
      return 'Invalid phone number';
    }
    return null;
  }
}
//email validaton
class EmailValidator {
  static final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@gmail\.com$');

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid Gmail address';
    }
    return null;
  }
}
//passwordValidator field
class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 4 || value.length > 8) {
      return 'Password must be between 4 and 8 characters';
    }
    return null;
  }
}

class VentureValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }
    if (value.startsWith(' ')) {
      return 'Name cannot start with a space';
    }
    RegExp regExp = RegExp(r"^[A-Za-z][A-Za-z ]*$");
    if (!regExp.hasMatch(value)) {
      return 'Name must only contain letters and spaces';
    }
    int letterCount = value.replaceAll(RegExp(r'[^A-Za-z]'), '').length;
    if (letterCount < 4) {
      return 'Name must contain at least 4 letters';
    }
    return null;
  }
}
class ConfirmPasswordValidator {
  static String? validate(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}



class EmailTwoValidator {
  static String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email) ? null : 'Please enter a valid email address';
  }
}

class PasswordValidatorTwo {
  static String? validate(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 4 || password.length > 8) {
      return 'Password must be between 4 and 8 characters';
    }
    return null;
  }
}
