import 'dart:ui';

import 'package:flutter/material.dart';

class SalePrice extends StatefulWidget {
  final String hintText;
  final double height;

  const SalePrice({
    super.key,
    required this.hintText,
    required this.height,
  });

  @override
  State<SalePrice> createState() => _FieldDecorationState();
}

class _FieldDecorationState extends State<SalePrice> {
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.5,
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
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0), 
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Color.fromARGB(95, 94, 94, 94),fontFamily: 'Poppins',  fontWeight: FontWeight.w400,  ),
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

