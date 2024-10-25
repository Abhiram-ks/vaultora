import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../validation/validation.dart';


//singup_login_screen_decoration_portion_username
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                filled: false,
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                labelStyle:
                    const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                border: InputBorder.none, 
              ),
              style: const TextStyle(color: Colors.white),
              validator: NameValidator.validate,
            ),
          ),
        ),
      ),
    );
  }
}

//singup_login_screen_decoration_portion_phoneNumber
class CustomPhonenumber extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const CustomPhonenumber({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                filled: false,
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                labelStyle:
                    const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, letterSpacing: 5),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: PhoneNumberValidator.validate,
            ),
          ),
        ),
      ),
    );
  }
}


//singup_login_screen_decoration_portion_email
class CustomTextFieldtwo extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const CustomTextFieldtwo({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Optional: To round the corners
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                filled: false,
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                labelStyle:
                    const TextStyle(color: Colors.white, fontFamily: 'poppins'),
                border: InputBorder.none, 
              ),
              style: const TextStyle(color: Colors.white),
              validator: EmailValidator.validate,
            ),
          ),
        ),
      ),
    );
  }
}