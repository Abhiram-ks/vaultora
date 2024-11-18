import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../../db/models/user/user.dart';
import '../../main page/main_page.dart';
import '../landscren/screen_land.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<double> _colorAnimation;
  UserModel? lastLoggedUser;

  @override
  void initState() {
    super.initState();
    checkLoggedUser();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkLoggedUser() async {
    var sessionBox = await Hive.openBox('sessionBox');
    lastLoggedUser = sessionBox.get('lastLoggedUser') as UserModel?;

    if (lastLoggedUser != null) {
      gotoLoggedUser();
    } else {
      gotoLogin();
    }
  }

  Future<void> gotoLoggedUser() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Homepage(userDetails: lastLoggedUser!),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const LandingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double titleFontSize = screenWidth * 0.1;
    double subtitleFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _logoAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/welcome/Screenshot_2024-10-22_112608-transformed.png',
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.05),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: const [Colors.red, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        _colorAnimation.value,
                        _colorAnimation.value + 0.3
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Vaultora',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Opacity(
                  opacity: _controller.value,
                  child: Text(
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
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${(_controller.value * 100).toInt()}%',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: LinearProgressIndicator(
                value: _controller.value,
                backgroundColor: Colors.white24,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
