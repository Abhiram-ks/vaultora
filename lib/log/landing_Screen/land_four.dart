import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/splash_and_welcome/welcome_screen.dart';

import '../validation_login/orline_dec.dart';


class ScreenFour extends StatefulWidget {
  const ScreenFour({super.key});

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}
class _ScreenFourState extends State<ScreenFour> {
  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    final screenFour= ScreenColor(colors: [
    const Color.fromARGB(255, 198, 42, 255),
    const Color.fromRGBO(253, 232, 136, 1)
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Container(
           decoration: screenFour.gradientDecoration,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                Lottie.asset(
                  'assets/gif/Animation - 1729709009658.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
              const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        '"Monitor your growth to celebrate progress and stay aware of your journey."',
                        textAlign: TextAlign.center, // Center align text
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
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
              child: Row(
                children: [
                  Text(
                    'Let’s get start',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const CheckScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Click',
                      style: TextStyle(fontSize: 16),
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
