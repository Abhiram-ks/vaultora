import 'package:flutter/material.dart';

import '../validation/validation.dart';
 //field for password
class PasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  const PasswordField({
    super.key,
    required this.labelText,
    required this.hintText,

  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}
 //singup_login_screen_decoration_portion_passwordFiled
class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white54,),
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
      style: const TextStyle(color: Colors.white,fontFamily: 'poppins',fontWeight: FontWeight.w400),
      validator: PasswordValidator.validate,
    );
  }
}
