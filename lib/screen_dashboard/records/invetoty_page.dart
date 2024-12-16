import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaultora_inventory_app/db/helpers/salefuction.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/sales/sales_category.dart';

import '../../Color/colors.dart';
import '../../db/helpers/addfunction.dart';
import '../common/appbar.dart';
import '../home_page/subfiles_home/page_view.dart';
import 'product/product_records/subfiles_product_reocrd/purchase_category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
   final PageController _pageController = PageController();

  int _currentPage = 0;
  late Timer _pageTimer;

  @override
  void initState() {
    super.initState();
     getAllItems(); 
     getAllSales();

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
 final List<Map<String, dynamic>> pageData = [
      {
        'image': 'assets/listimage/image3.jpg',
        'title': 'Real-time Tracking',
        'subtitle': 'UPDATES STOCK LEVELS INSTANTLY',
        'subtitle2': 'An Inventory App is a digital tool that helps',
        'subtitle3': 'businesses keep track of their products,',
        'subtitle4': 'stock levels and orders in real-time.',
        'color': const Color.fromARGB(255, 171, 174, 118),
      },
      {
        'image': 'assets/listimage/image4.jpg',
        'title': 'Revenue',
        'subtitle': 'PROFIT TRACKER, MONITORING GAINS',
        'subtitle2': 'Revenue is the total income a business',
        'subtitle3': ' earns from selling goods or services before ',
        'subtitle4': 'any costs or expenses are subtracted.',
        'color': const Color.fromARGB(255, 62, 58, 58),
      },
      {
         'image': 'assets/listimage/image6.jpg',
        'title': 'Universal Language ',
        'subtitle': 'CONNECTS PEOPLE ACROSS CULTURES',
        'subtitle2': 'Music is the art of combining sounds to express emotion,',
        'subtitle3': 'tell stories, and connect people. It’s a universal ',
        'subtitle4': 'language that inspires and unites across cultures.',
        'color': Colors.blue[300],
      },
      {
        'image': 'assets/listimage/image2.jpg',
        'title': 'Stock Management',
        'subtitle': 'MONITORS INVENTORY LEVELS EFFICIENTLY',
        'subtitle2': 'Stock is the supply of goods a business holds to',
        'subtitle3': 'meet customer demand, ensuring smooth',
        'subtitle4': 'operations and preventing shortages.',
        'color': const Color.fromARGB(255, 113, 93, 66),
      },
      {
       'image': 'assets/listimage/image1.jpg',
        'title': 'Seamless Experience',
        'subtitle': 'Enjoy the Features of the APP',
        'subtitle2': 'Inventory is the collection of goods a business keeps on',
        'subtitle3': 'hand to fulfill customer needs, supporting efficient ',
        'subtitle4': 'operations and preventing stockouts.',
        'color': const Color.fromARGB(255, 213, 89, 170),
      },
    ];

 return Scaffold(
   appBar: const MyAppBar(
    titleText: 'Inventory ',
    animationPath: 'assets/gif/truck.json',
      ),
     body: SingleChildScrollView(
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: screenWidth*0.03,),
        child:  Column(
          children: [
            SizedBox(height: screenHeight*0.02,),
            GestureDetector(
              onDoubleTap: () {
                
              },
              child: SizedBox(
                    height: screenHeight / 4,
                    width: double.infinity,
                    child: PageviewBuilder(
                      pageController: _pageController,
                      itemCount: pageData.length,
                      pageData: pageData,
                    ),
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
                    dotColor: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                ValueListenableBuilder<int>(valueListenable: itemCountNotifier,
                 builder:  (context, count, child){
                  return  PurchaseCategory(volume: count.toString());
                 }
                 ),
               
                SizedBox(height: screenHeight * 0.02),
                ValueListenableBuilder<int>(valueListenable: saleCountNotifier,
                builder:  (context, count, child){
                  return SalesCategory(volule: count.toString(),);
                },
                )
                ,
          ],
        ),),
    ),
 );
  }
}