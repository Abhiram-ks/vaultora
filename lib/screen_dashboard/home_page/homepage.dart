import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaultora_inventory_app/db/models/category/catalog.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/product_records/subfiles_product_reocrd/action_popup.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/Category_add/update_category.dart';
import 'package:vaultora_inventory_app/screen_dashboard/home_page/subfiles_home/create_card.dart';
import 'package:vaultora_inventory_app/screen_dashboard/home_page/drewer/drewer.dart';
import 'package:vaultora_inventory_app/screen_dashboard/home_page/subfiles_home/home_appbar.dart';
import 'package:vaultora_inventory_app/screen_dashboard/home_page/subfiles_home/page_view.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/product_records/subfiles_product_reocrd/inventory_home.dart';
import '../../../Color/colors.dart';
import '../../db/helpers/categoryfunction.dart';

class HomePage extends StatefulWidget {
  final UserModel userDetails;
  const HomePage({
    super.key,
    required this.userDetails,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];

  final PageController _pageController = PageController();

  int _currentPage = 0;
  late Timer _pageTimer;

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
  }

  @override
  void dispose() {
    _pageTimer.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final List<Color> cardColors = [
      const Color.fromARGB(255, 29, 66, 77),
      const Color.fromARGB(255, 40, 98, 116),
      const Color.fromARGB(255, 59, 140, 164),
      const Color.fromARGB(255, 125, 185, 203),
      const Color.fromARGB(255, 40, 98, 116),
    ];

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
      drawer: AppDrawer(userDetails: widget.userDetails),
      appBar: const HomeAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
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
                activeDotColor: black,
                dotColor: grey,
              ),
            ),
            SizedBox(height: screenHeight * 0.024),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Inventory Functions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: grey,
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.024),
            const InventoryHome(),
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
            ValueListenableBuilder<List<CategoryModel>>(
              valueListenable: categoryListNotifier,
              builder: (context, categories, child) {
                return categories.isEmpty
                    ?  Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          color:inside,
                        )),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: SizedBox(
                          height: screenHeight / 5,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final backgroundColor =
                                  cardColors[index % cardColors.length];
                              return CreateCard(
                                imagePath: category.imagePath,
                                title: category.categoryName,
                                categoryId: category.id,
                                onDelete: () {
                                  showDeleteConfirmation(context, category.id);
                                },
                                onEdit: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor:transParent,
                                      builder: (BuildContext context) {
                                        return EditBottomSheet(
                                          id: category.id,
                                          imagePath: category.imagePath,
                                          categoryName: category.categoryName,
                                        );
                                      });
                                },
                                backgroundColor: backgroundColor,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: screenWidth * 0.04);
                            },
                          ),
                        ),
                      );
              },
            ),
            SizedBox(height: screenHeight * 0.08),
          ]),
        ),
      ),
    );
  }
}
