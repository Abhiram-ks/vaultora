import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';
import 'package:vaultora_inventory_app/db/models/category/catalog.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_page.dart';
import 'package:vaultora_inventory_app/main%20page/home/create_card.dart';

import 'package:vaultora_inventory_app/main%20page/home/home_appbar.dart';
import 'package:vaultora_inventory_app/main%20page/home/inventory_card.dart';
import 'package:vaultora_inventory_app/main%20page/home/page_view.dart';

import '../../db/functions/categoryfunction.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required UserModel userDetails,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];

  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  int _scrollIndex = 0;
  late Timer _pageTimer;
  late Timer _scrollTimer;

  @override
  void initState() {
    super.initState();
    _pageTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
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

    _scrollTimer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_scrollIndex < 3) {
        _scrollIndex++;
      } else {
        _scrollIndex = 0;
      }
      _scrollController.animateTo(
        _scrollIndex * 160.0,
        duration: const Duration(microseconds: 770),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageTimer.cancel();
    _scrollTimer.cancel();
    _pageController.dispose();
    _scrollController.dispose();
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
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 29, 66, 77),
        expandedHeight: screenHeight * 0.15,
        pinned: true,
        flexibleSpace: const FlexibleSpaceBar(
          background: HomeAppbar(),
        ),
      ),
      SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(children: [
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Inventory Functions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey,
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.024),
                SizedBox(
                  height: screenHeight / 5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InventoryFunction(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddPage()));
                        },
                        imagePath: 'assets/category/animation(6).json',
                        title: 'Purchase',
                        subtitle: 'SUPPLY SUMMARY',
                        color: const Color.fromARGB(255, 174, 222, 246),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      InventoryFunction(
                          onTap: () { 
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AddPage()));
                          },
                          color: const Color.fromARGB(255, 226, 212, 255),
                          imagePath: 'assets/category/animation(2).json',
                          title: 'Revenue',
                          subtitle: 'PROFIT TRACKER'),
                      SizedBox(width: screenWidth * 0.03),
                      InventoryFunction(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddPage()));
                        },
                        imagePath: 'assets/gif/twoanimation.json',
                        title: 'Sales',
                        subtitle: 'INCOME INSIGHTS',
                        color: const Color.fromARGB(255, 245, 246, 174),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      InventoryFunction(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddPage()));
                        },
                        imagePath: 'assets/gif/welcome one.json',
                        title: 'Products ',
                        subtitle: 'INVENTORY OVERVIEW',
                        color: const Color.fromARGB(255, 250, 246, 21),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.024),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.024),
                SizedBox(
                  height: screenHeight / 5,
                  child: ListView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      const CustomCard(
                          color: Color.fromARGB(255, 255, 193, 214),
                          imagePath: 'assets/category/file.png',
                          title: 'Earphone'),
                      SizedBox(width: screenWidth * 0.04),
                      const CustomCard(
                          color: Colors.yellow,
                          imagePath: 'assets/category/file (3).png',
                          title: 'Over Head'),
                      SizedBox(width: screenWidth * 0.04),
                      const CustomCard(
                          color: Color.fromARGB(255, 76, 175, 122),
                          imagePath: 'assets/category/file (2).png',
                          title: 'Neckband'),
                      SizedBox(width: screenWidth * 0.04),
                      const CustomCard(
                          color: Color.fromARGB(255, 190, 211, 113),
                          imagePath: 'assets/category/file (1).png',
                          title: 'Earbuds'),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                ValueListenableBuilder<List<CategoryModel>>(
                    valueListenable: categoryListNotifier,
                    builder: (context, categories, child) {
                      return categories.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: screenHeight / 5,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    return CreateCard(
                                      imagePath: category.imagePath ,
                                      title: category.categoryName,
                                      categoryId: category.id,
                                      onDelete: () async {
                                        await deleteCategory(category.id);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: screenWidth * 0.04);
                                  },
                                ),
                              ),
                            );
                    }),
              ]),
            ),
          )),
    ]));
  }
}
