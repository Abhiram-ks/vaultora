import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                 Color.fromARGB(255, 88, 179, 248),
              Color.fromARGB(255, 216, 240, 137)
                ],
               begin: Alignment.topCenter, end: Alignment.bottomCenter
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: size.height  * 0.02),
                Lottie.asset(
                  'assets/gif/Animation - 1729708985261.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child:  Text(
                        '"An admin inventory app streamlines stock management."\n'
                        '"orders, and alerts for efficient operations."',
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
           Padding(
                  padding: EdgeInsets.only(right:size.width * 0.1,),
                  child:const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                        'swipe->',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                  ),
                ),
      
        ],
      ),
    );
  }
}