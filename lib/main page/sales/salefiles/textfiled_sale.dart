import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextFieldsale extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller; 
  final String? Function(String? value) validate; 

  const CustomTextFieldsale({
    super.key, 
    required this.hintText,
    required this.labelText,
     this.obscureText = false,
    required this.controller, 
    required this.validate, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, 
      obscureText: obscureText,
      validator: validate, 
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: true,
        fillColor: Colors.transparent,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 84, 84, 84)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}



class CustomTextFieldsalePhone extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller; 
  final String? Function(String? value) validate; 

  const CustomTextFieldsalePhone({
    super.key, 
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    required this.controller, 
    required this.validate, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, 
      obscureText: obscureText,
      validator: validate, 
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: true,
        fillColor: Colors.transparent,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 84, 84, 84)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      style: const TextStyle(color: Colors.black, letterSpacing: 5), // Black text color
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
