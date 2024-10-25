import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';
import 'package:vaultora_inventory_app/login/decorationLand/decoration.dart';

import '../../home/homepage.dart';
import '../decorationLand/decoration2.dart';
import '../decorationLand/decoration_landing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _vaultoraSlideAnimation;
  late Animation<Offset> _welcomeSlideAnimation;
 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _vaultoraSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _welcomeSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
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
    double titleFontSize = screenWidth * 0.07;
    double subtitleFontSize = screenWidth * 0.04;
    final mediaQuery = MediaQuery.of(context);
    final keyboardVisible = mediaQuery.viewInsets.bottom > 0;
    final topPadding = keyboardVisible ? screenHeight * 0.05 : screenHeight * 0.07;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome/main image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.83),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: topPadding),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/welcome/Screenshot_2024-10-22_112608-transformed.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  

                  SlideTransition(
                    position: _vaultoraSlideAnimation,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Vaultora',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tech You Can Trust, Prices You\'ll Love!',
                      style: GoogleFonts.poppins(
                        color: greyColor,
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.14),


                  SlideTransition(
                    position: _welcomeSlideAnimation,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome back!',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * 0.03),
                  const CustomTextFieldtwo(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const PasswordField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  
                   SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>const Homepage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3451FF),
                          padding:const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: textColor2,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(height: screenHeight*0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
