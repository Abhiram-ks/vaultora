//validation for user name
class NameValidator{
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
  static String? validate(String? value){
  if(value == null || value.isEmpty){
    return 'please enter phone number';
  }
  if(value.length != 10){
    return 'invalid phone number';
  }
  return null;
  }
 }

//email validaton
class EmailValidator {
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  static var validate;

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}

//passwordValidator field
class PasswordValidator {
  static var validate;

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
