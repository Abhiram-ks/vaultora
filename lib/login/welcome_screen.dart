import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class checkScreen extends StatefulWidget {
  const checkScreen({super.key});

  @override
  State<checkScreen> createState() => _checkScreenState();
}

class _checkScreenState extends State<checkScreen> {
  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // return Scaffold(
    //   body: Center(
    //     // child: Text('data'),
    //     child: Lottie.asset('assets/gif/welcome_vaultora.json'),
    // ),
    // );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(
            'assets/welcome/main image.jpg',
          fit: BoxFit.cover,
          ),
          ),
          Positioned.fill(child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Container(
                
              )
            ],
          ))
        ],
      ),
    );
  } 
}