import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../Color/colors.dart';
import '../RegestraioandLogin/login_page.dart';
import '../onbording/onbording_screen.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome/main image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: black.withOpacity(0.83),
          ),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                ),
                height: screenHeight * 0.3,
                child: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.3,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        aspectRatio: 16 / 9,
                      ),
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.01),
                          child: Lottie.asset(
                            'assets/gif/welcome_vaultora.json',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.6,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.01),
                          child: Lottie.asset(
                            'assets/gif/dataanalisics.json',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.6,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.01),
                          child: Lottie.asset(
                            'assets/gif/threeanimation.json',
                            fit: BoxFit.contain,
                            height: screenHeight * 0.6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.2,
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors:[const Color.fromARGB(255, 58, 58, 58), whiteColor, const Color.fromARGB(255, 100, 100, 100)],
                        stops: [
                          _animation.value - 0.2,
                          _animation.value,
                          _animation.value + 0.2
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: child,
                  );
                },
                child: Text(
                  'Vaultora',
                  style: GoogleFonts.poppins(
                    color: whiteColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                'An admin inventory app streamlines\n'
                'stock management, orders, and alerts\n'
                'for efficient operations.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: textColor2,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3451FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child:  Text(
                          'Sign Up',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1)),
                   Text(
                    'Already have an account?',
                    style: TextStyle(color: whiteColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: const Text(
                      '\tLogin',
                      style: TextStyle(color: Color.fromARGB(255, 0, 102, 255)),
                    ),
                  )
                ],
              ),SizedBox( height: screenHeight * 0.11,),
            ],
          ))
        ],
      ),
    );
  }
}
