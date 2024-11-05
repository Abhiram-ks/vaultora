import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';
import 'package:vaultora_inventory_app/main%20page/home/home_appbar.dart';
import 'package:vaultora_inventory_app/main%20page/home/page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 410),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> pageData = [
      {
        'image': 'assets/liquid/girl.jpg',
        'title': 'Real-time Tracking',
        'subtitle': 'UPDATES STOCK LEVELS INSTANTLY',
        'subtitle2': 'An Inventory App is a digital tool that helps',
        'subtitle3': 'businesses keep track of their products,',
        'subtitle4': 'stock levels and orders in real-time.',
        'color': const Color.fromARGB(255, 171, 174, 118),
      },
      {
        'image': 'assets/liquid/growth.jpg',
        'title': 'Revenue',
        'subtitle': 'PROFIT TRACKER, MONITORING GAINS',
        'subtitle2': 'Revenue is the total income a business',
        'subtitle3': ' earns from selling goods or services before ',
        'subtitle4': 'any costs or expenses are subtracted.',
        'color': const Color.fromARGB(255, 62, 58, 58),
      },
      {
        'image': 'assets/liquid/manwith headset.jpg',
        'title': 'Universal Language ',
        'subtitle': 'CONNECTS PEOPLE ACROSS CULTURES',
        'subtitle2': 'Music is the art of combining sounds to express emotion,',
        'subtitle3': 'tell stories, and connect people. It’s a universal ',
        'subtitle4': 'language that inspires and unites across cultures.',
        'color': Colors.blue[300],
      },
      {
        'image': 'assets/liquid/5363923.jpg',
        'title': 'Stock Management',
        'subtitle': 'MONITORS INVENTORY LEVELS EFFICIENTLY',
        'subtitle2': 'Stock is the supply of goods a business holds to',
        'subtitle3': 'meet customer demand, ensuring smooth',
        'subtitle4': 'operations and preventing shortages.',
        'color': const Color.fromARGB(255, 113, 93, 66),
      },
      {
        'image':
            'assets/liquid/happy-girl-singing-favorite-song-listening-music-wireless-headphones-smiling-dancing-standing-pink-background.jpg',
        'title': 'Seamless Experience',
        'subtitle': 'Enjoy the Features of the APP',
        'subtitle2': 'Inventory is the collection of goods a business keeps on',
        'subtitle3': 'hand to fulfill customer needs, supporting efficient ',
        'subtitle4': 'operations and preventing stockouts.',
        'color': const Color.fromARGB(255, 213, 89, 170),
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 29, 66, 77),
            expandedHeight: screenHeight * 0.17,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              background: HomeAppbar(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 4,
                        width: double.infinity,
                        child: PageviewBuilder(
                          pageController: _pageController,
                          itemCount: pageData.length,
                          pageData: pageData,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.024),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: pageData.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: textColor1,
                          dotColor: Colors.grey,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.024),
//                       Text(
//   'Category',
//   style: GoogleFonts.kodchasan(
//     fontSize: 20,        // Adjust font size
//     color: Colors.black,  // Adjust color if needed
//   ),
// )
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                         SizedBox(height: screenHeight * 0.024),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
