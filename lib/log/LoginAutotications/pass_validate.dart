import 'package:flutter/material.dart';

import '../../Color/colors.dart';


class PasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const PasswordField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            } else if (value.length < 4 || value.length > 6) {
              return 'Password must be between 4 and 6 characters';
            }
            return widget.validator(value);
          },
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
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.white54,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
          style:  TextStyle(
            color: whiteColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}


