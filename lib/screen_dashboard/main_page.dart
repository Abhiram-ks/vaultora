
import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/screen_add/addpage.dart';

import 'records/invetoty_page.dart';
import 'home_page/homepage.dart';
import 'profile/profile_screen/profile_page.dart';
import 'package:vibration/vibration.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.userDetails});
  final UserModel userDetails;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.22,
    initialPage: 0,
  );
  int _currentIndex = 0;

  final List<IconData> icons = [
    Icons.home,
    Icons.add,
    Icons.shopping_cart,
    Icons.person,
  ];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(userDetails: widget.userDetails),
      Addpage(userDetails: widget.userDetails),
      const CategoryPage(),
      ProfilePage(userDetails: widget.userDetails),
    ]);
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 90,
              child: PageView.builder(
                controller: _pageController,
                itemCount: icons.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  _vibrate();
                },
                itemBuilder: (context, index) {
                  double scale = _currentIndex == index ? 0.7 : 0.5;
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: scale, end: scale),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, double scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              _currentIndex = index;
                            });
                            _vibrate();
                          },
                          child: Tooltip(
                            message: index == 1
                                ? "Revenue and Stock Scroll"
                                : "Navigate",
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                boxShadow: _currentIndex == index
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0, 2),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                    : [],
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Colors.white
                                    : const Color.fromRGBO(184, 182, 182, 0.4),
                              ),
                              child: Center(
                                child: Icon(
                                  icons[index],
                                  color: _currentIndex == index
                                      ? const Color(0xFF8C8C8C)
                                      : Colors.white,
                                  size: _currentIndex == index ? 35 : 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}