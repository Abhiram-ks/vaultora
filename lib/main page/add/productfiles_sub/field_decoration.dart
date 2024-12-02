import 'dart:ui';
import 'package:flutter/material.dart';

class FieldDecoration extends StatefulWidget {
  final String hintText;
  final double height;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String? value) validate;
  const FieldDecoration({
    super.key,
    required this.hintText,
    required this.height,
    this.obscureText = false,
    required this.controller,
    required this.validate,
  });

  @override
  State<FieldDecoration> createState() => _FieldDecorationState();
}

class _FieldDecorationState extends State<FieldDecoration> {
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
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color.fromARGB(96, 94, 94, 94), fontFamily: 'Poppins', fontWeight: FontWeight.w400),
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
class InputValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty'.capitalize();
    } else if (value.startsWith(' ')) {
      return 'No spaces allowed at the start'.capitalize();
    }
    return null;
  }
}

extension CapitalizeExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}


class FieldText extends StatelessWidget {
  final String text;
  final IconData icon;

  const FieldText({required this.text, required this.icon, super.key,});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 29, 66, 77),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                   const Text(
                  ' *',
                  style:  TextStyle(
                    color: Color.fromARGB(255, 255, 17, 0),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Icon(icon, size: 18, color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}


