import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/login/welcome_screen.dart';
import 'package:vaultora_inventory_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    
    
    _lineAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: false);
    
    gotoLogin();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double titleFontSize = screenWidth * 0.1;
    double subtitleFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/welcome/Screenshot 2024-10-22 112608.png',
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: screenWidth * _lineAnimation.value, 
                  child: Container(
                    width: screenWidth * 0.2  ,
                    height: 4,
                    color: Colors.blue, // Blue color for the line
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenWidth * 0.05,
            ),
            Text(
              'Vaultora',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenWidth * 0.02,
            ),
            Text(
              'An admin inventory app streamlines\n'
              'stock management, orders, and alerts\n'
              'for efficient operations.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
    Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacement( 
      MaterialPageRoute(
        builder: (ctx) => checkScreen(),
      ),
    );
  }
}
