import 'dart:ui';
import 'package:flutter/material.dart';

import '../../Color/colors.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required String? Function(String? value) validate,
    this.validator,
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
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                filled: false,
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                labelStyle:
                     TextStyle(color: whiteColor, fontFamily: 'poppins'),
                border: InputBorder.none,
              ),
              style:  TextStyle(color: whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}


