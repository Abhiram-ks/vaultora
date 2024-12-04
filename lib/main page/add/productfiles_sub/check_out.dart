import 'package:flutter/material.dart';

import 'dart:ui'; 

class CheckOut extends StatelessWidget {
  final String hintText;
  final double height;
  final Color color;
  final VoidCallback onTap;

  const CheckOut({
    super.key,
    required this.hintText,
    required this.height,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: onTap, 
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              padding: const EdgeInsets.all(9.0),
              color: color.withOpacity(0.9), 
              child: Center(
                child: Text(
                  hintText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}