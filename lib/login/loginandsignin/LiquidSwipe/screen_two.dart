import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                 Color.fromARGB(255, 224, 248, 88),
              Color.fromARGB(255, 139, 240, 137)
                ],
               begin: Alignment.topCenter, end: Alignment.bottomCenter
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: size.height  * 0.02),
                Lottie.asset(
                  'assets/gif/Security3.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child:  Text(
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
         
        ],
      ),
    );
  }
}