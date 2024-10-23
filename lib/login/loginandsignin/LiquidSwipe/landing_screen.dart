import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:vaultora_inventory_app/login/loginandsignin/LiquidSwipe/screen_two.dart';
import 'screen_one.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final List<Widget> pages = [
    const ScreenOne(),
    const ScreenTwo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false, 
        slideIconWidget: const Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Colors.white,
        ),
        waveType: WaveType.liquidReveal,
        fullTransitionValue: 600,
      ),
    );
  }
}
