import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/log/landscren/land_four.dart';
import 'land_one.dart';
import 'land_three.dart';
import 'land_two.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final List<Widget> pages = [
    const ScreenOne(),
    const ScreenTwo(),
    const ScreenThree(),
    const ScreenFour(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false, 
        slideIconWidget: Icon(
          Icons.arrow_back_ios,
          size: 30,
          color:whiteColor,
        ),
        waveType: WaveType.liquidReveal,
        fullTransitionValue: 600,
      ),
    );
  }
}
