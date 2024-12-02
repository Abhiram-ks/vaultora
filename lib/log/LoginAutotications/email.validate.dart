import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/log/LoginAutotications/validation.dart';

class EmailField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const EmailField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EmailFieldState createState() => _EmailFieldState();
}
class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: whiteColor.withOpacity(0.1),
        labelStyle:  TextStyle(color: whiteColor),
        hintStyle: const TextStyle(color: Colors.white54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style:  TextStyle(
        color: whiteColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      validator: EmailTwoValidator.validate,
    );
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