import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/log/onbording/onbording_class.dart';
import 'package:vaultora_inventory_app/log/RegestraioandLogin/register_page.dart';

import '../../Color/colors.dart';
import '../Login_autotications/bg_stack.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {super.initState(); _pageController = PageController();}

  @override
  void dispose() {_pageController.dispose(); super.dispose();}
  void _onPageChanged(int index) {setState(() {_currentIndex = index;});}

  void _onNextPressed() { _pageController.nextPage(duration: const Duration(milliseconds: 300),curve: Curves.easeInOut,);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    final keyboardVisible = mediaQuery.viewInsets.bottom > 0;
    final topPadding = keyboardVisible ? screenHeight * 0.1 : screenHeight * 0.16;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
        const BgimageRegisterLogin(),
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Opacity(
                    opacity: _currentIndex == index ? 1.0 : 0.5,
                    child: index == 0
                        ? _buildPage1(topPadding, screenWidth)
                        : _buildPage2(topPadding, screenWidth),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 80,left: screenWidth / 2 - 30,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 10,width: _currentIndex == index ? 25 : 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
            ),
          ),SizedBox(height: screenHeight * 0.1),
        ],
      ),floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width: screenWidth * 0.8,height: 50,
          child: ElevatedButton(
            onPressed: _currentIndex == 0
                ? _onNextPressed
                : () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3451FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              _currentIndex == 0 ? 'Next' : 'Register Now',
              style: TextStyle(
                fontSize: 18,color: textColor2,fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget _buildPage1(double topPadding, double screenWidth) {
    return const CenteredImageWithText(imagePath: 'assets/liquid/Privacy policy-bro.png', text: 'At Ventura Inventory App, we are committed to protecting your privacy and ensuring that your personal information is handled responsibly. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application. Please read this policy carefully to understand our practices regarding your information. ');
  }
  Widget _buildPage2(double topPadding, double screenWidth) {
      return const  CenteredImageWithText(imagePath: 'assets/liquid/Timeline-bro.png', text: 'Vantora optimizes inventory and revenue management with real-time analytics, enabling businesses to streamline processes, prevent stock issues, and uncover new growth opportunities. By enhancing inventory control and maximizing profitability, Vantora supports long-term business efficiency and strategic growth.');
  }
}
