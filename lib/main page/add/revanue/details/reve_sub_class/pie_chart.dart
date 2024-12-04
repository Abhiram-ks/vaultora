import 'dart:ui';

import 'package:flutter/material.dart';

class PieChart extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const PieChart({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.08,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          child: Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 29, 66, 77).withOpacity(0.1),
            child: Text(
                    'hellow',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ),
    );
  }
}
