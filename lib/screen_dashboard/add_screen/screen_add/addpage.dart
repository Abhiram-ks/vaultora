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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String animationPath = _currentIndex == 0
        ? 'assets/category/animation(6).json' 
        : 'assets/category/animation(2).json'; 

    return Scaffold(
      appBar: MyAppBar(
        titleText: _currentIndex == 0 ? 'Add to catalog' : 'Revenue & Stock Management',
        animationPath: animationPath,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: 2,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
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
    );
  }
}