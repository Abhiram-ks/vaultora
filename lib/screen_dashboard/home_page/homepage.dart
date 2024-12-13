import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaultora_inventory_app/db/models/category/catalog.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/Category_add/category_add.dart';
import 'package:vaultora_inventory_app/screen_dashboard/home_page/subfiles_home/homepage_configuration.dart';
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
    return Scaffold(
      backgroundColor: whiteColor,
      drawer: AppDrawer(userDetails: widget.userDetails),
      appBar: const HomeAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(children: [
            SizedBox( height: screenHeight * 0.02, ),
            SizedBox(
              height: screenHeight / 4,
              width: double.infinity,
              child: PageviewBuilder(
                pageController: _pageController,
                itemCount: HomePageConfiguration.pageData.length,
                pageData: HomePageConfiguration.pageData,
              ),
            ), SizedBox(height: screenHeight * 0.024),
            SmoothPageIndicator(
              controller: _pageController,
              count: HomePageConfiguration.pageData.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: black,
                dotColor: grey,
              ),
            ), SizedBox(height: screenHeight * 0.024),
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
                Icon( Icons.arrow_forward_ios_rounded,
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
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AddCategoryDialog( userId: widget.userDetails.id),
                                  );
                                },child: const Text('No add one!')),
                                CircularProgressIndicator(color: inside, ),
                          ],
                        )),
                      ): Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: SizedBox(
                          height: screenHeight / 5,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final backgroundColor =HomePageConfiguration.cardColors[index %HomePageConfiguration.cardColors.length];
                              return CreateCard(
                                imagePath: category.imagePath,
                                title: category.categoryName,
                                categoryId: category.id,
                                onDelete: () {showDeleteConfirmation(context, category.id);
                                }, onEdit: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: transParent,
                                      builder: (BuildContext context) {
                                        return EditBottomSheet(
                                          id: category.id,
                                          imagePath: category.imagePath,
                                          categoryName: category.categoryName,
                                        );
                                      });
                                }, backgroundColor: backgroundColor,
                              );
                            }, separatorBuilder: (context, index) {
                              return SizedBox(width: screenWidth * 0.04);
                            },
                          ),
                        ),
                      );
               },
            ), SizedBox(height: screenHeight * 0.08),
          ]),
        ),
      ),
    );
  }
}
