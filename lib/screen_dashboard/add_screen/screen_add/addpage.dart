import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/screen_add/subfiles_add/page_one_add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/screen_add/subfiles_add/page_two_add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/common/appbar.dart';
import '../../../../db/models/user/user.dart';

class Addpage extends StatefulWidget {
  final UserModel userDetails;
  const Addpage({super.key, required this.userDetails});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
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

  void handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String getAnimationPath(int index) {
      return index == 0
          ? 'assets/gif/purchase.json'
          : 'assets/gif/truck.json';
    }

    return Scaffold(
      appBar: MyAppBar(
        titleText: _currentIndex == 0
            ? 'Add to Catalog'
            : 'Revenue & Stock Management',
        animationPath: getAnimationPath(_currentIndex),
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemCount: 2,
            onPageChanged: handlePageChange,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AddProductPage(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  userDetails: widget.userDetails,
                );
              } else if (index == 1) {
                return RevenueAndLogisticPage(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          if (_currentIndex > 0)
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 10),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value), 
                        child: AnimatedOpacity(
                          opacity: _currentIndex > 0 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          if (_currentIndex < 1)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: -10),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: AnimatedOpacity(
                          opacity: _currentIndex < 1 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
