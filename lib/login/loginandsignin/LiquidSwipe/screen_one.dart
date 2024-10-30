import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/login/decorationLand/decoration_landing.dart';

import 'screen_four.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
        final screenOne = ScreenColor(colors: [
     Colors.white,
     Colors.white,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Container(
           decoration: screenOne.gradientDecoration,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                Lottie.asset(
                  'assets/gif/timefile.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
              const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        '"Offer seamless solutions to track stock levels."\n'
                        '"Time is what we want most, but what we use worst."',
                        textAlign: TextAlign.center, 
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
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenFour(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                 const Text(
                    'swipe->',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
