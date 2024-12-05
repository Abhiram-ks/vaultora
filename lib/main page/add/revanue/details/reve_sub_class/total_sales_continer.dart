import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBackgroundCard extends StatelessWidget {
  final String title;
  final String number;
  final double screenHeight;
  final double screenWidth;

  const BlurredBackgroundCard({
    super.key,
    required this.title,
    required this.number,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [                                              
        Container(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        number,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
               Icons.assignment_turned_in,
              color: const Color.fromARGB(255, 117, 155, 166).withOpacity(0.6 ),
              size: 60,
            ),
          ),
        ),
      ],
    );
  }
}
