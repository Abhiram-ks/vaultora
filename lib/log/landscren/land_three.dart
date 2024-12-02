import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

import '../Login_autotications/orline_dec.dart';


class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final screenThree= ScreenColor(colors: [
    const Color.fromARGB(255, 88, 179, 248), 
    const Color.fromARGB(255, 216, 240, 137)
    ]);
    return  Scaffold(
      body: Stack(
        children: [
          Container(
             decoration: screenThree.gradientDecoration,
            child: Column(
              children: [
                SizedBox(height: size.height  * 0.02),
                Lottie.asset(
                  'assets/gif/Animation - 1729708985261.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child:  Text(
                        '"An admin inventory app streamlines stock management."\n'
                        '"orders, and alerts for efficient operations."',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.9,
            left: size.width * 0.1,
            child: SizedBox(
              width: size.width * 0.8,
              child:Row(
                children: [
                   const Spacer(),
               
                   Align(
                    alignment: Alignment.bottomRight,
                    child:  Text(
                      'swipe->',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}