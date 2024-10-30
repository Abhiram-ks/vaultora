import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/login/REGISTER/onbording/register_page.dart';

import '../../../colors/colors.dart';
import '../../decorationLand/bg_image.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
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
          BgimageRegisterLogin(),
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
            bottom: 80,
            left: screenWidth / 2 - 30,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return AnimatedContainer(
                    duration:const Duration(milliseconds: 300),
                    height: 10,
                    width: _currentIndex == index ? 25 : 10,
                    margin:const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: screenHeight*0.1,)
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0), 
        child: SizedBox(
          width: screenWidth * 0.8, 
          height: 50, 
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const RegisterPage(),));
            },
            style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3451FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
            child: Text('Register Now', style: TextStyle(fontSize: 18, color:textColor2, fontWeight: FontWeight.w600 )),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildPage1(double topPadding, double screenWidth) {
    return const Center(child: Text("Page 1"));
  }

  Widget _buildPage2(double topPadding, double screenWidth) {
    return const Center(child: Text("Page 2"));
  }
}


