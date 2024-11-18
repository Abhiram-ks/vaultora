import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Color/colors.dart';

class CustomPhonenumber extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String? value) validate;

  const CustomPhonenumber({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: validate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                filled: false,
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                labelStyle: TextStyle(
                    color: whiteColor, fontFamily: 'poppins'),
                border: InputBorder.none,
              ),
              style: TextStyle(color: whiteColor, letterSpacing: 5),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//phoneNumbervalidation
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
