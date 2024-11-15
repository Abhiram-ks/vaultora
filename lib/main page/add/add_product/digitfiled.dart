import 'dart:ui';

import 'package:flutter/material.dart';

class DigitField extends StatefulWidget {
  final String hintText;
  final double height;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String? value) validate;
  final Function(String)? onChanged; // Optional onChanged parameter

  const DigitField({
    super.key,
    required this.hintText,
    required this.height,
    this.obscureText = false,
    required this.controller,
    required this.validate,
    this.onChanged, // Accept onChanged function
  });

  @override
  State<DigitField> createState() => _FieldDecorationState();
}

class _FieldDecorationState extends State<DigitField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            validator: widget.validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: widget.onChanged, // Trigger onChanged if provided
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color.fromARGB(96, 94, 94, 94),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}

class DigitInputValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    } 

    else if (value.contains(' ')) {
      return 'No spaces allowed';
    }
    
    else if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return 'No Letters allowed';
    }

    return null;
  }
}
