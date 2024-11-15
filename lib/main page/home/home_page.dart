import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';
import 'package:vaultora_inventory_app/db/models/category/catalog.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/check_out.dart';
import 'package:vaultora_inventory_app/main%20page/home/home_page_models/action_popup.dart';
import 'package:vaultora_inventory_app/main%20page/home/home_page_models/create_card.dart';
import 'package:vaultora_inventory_app/main%20page/home/home_page_models/home_appbar.dart';
import 'package:vaultora_inventory_app/main%20page/home/home_page_models/page_view.dart';
import 'package:vaultora_inventory_app/main%20page/home/inventory_card/inventory_home.dart';
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
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.pinkAccent,
      Colors.purpleAccent,
      Colors.orangeAccent,
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
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 29, 66, 77),
        expandedHeight: screenHeight * 0.13,
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
            SizedBox(height: screenHeight * 0.01),
            ValueListenableBuilder<List<CategoryModel>>(
              valueListenable: categoryListNotifier,
              builder: (context, categories, child) {
                return categories.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(child: CircularProgressIndicator()),
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
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return EditBottomSheet(
                                          id: category.id,
                                          imagePath: category.imagePath,
                                          categoryName: category.categoryName,
                                        );
                                      });
                                  // showEditConfirmation(
                                  //   context,
                                  //   category.id,
                                  //   category.imagePath,
                                  //   category.categoryName,
                                  // );
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
            )
          ]),
        ),
      )),
    ]));
  }
}

class EditBottomSheet extends StatefulWidget {
  final String id;
  final String imagePath;
  final String categoryName;

  const EditBottomSheet({
    super.key,
    required this.id,
    required this.imagePath,
    required this.categoryName,
  });

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController categoryController;
  late ValueNotifier<String> selectedImagePath;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.categoryName);
    selectedImagePath = ValueNotifier<String>(widget.imagePath);
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> updateCategoryInDB() async {
    String updatedCategoryName = categoryController.text;
    String updatedImagePath = selectedImagePath.value;

    bool success = await updateCategory(
      id: widget.id,
      categoryName: updatedCategoryName,
      imagePath: updatedImagePath,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category updated successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update category.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        height: screenHeight * 0.6,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color.fromARGB(255, 30, 59, 67),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.004),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 80.0,
                      height: 2.0,
                      color: const Color.fromARGB(255, 30, 59, 67),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03,),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          hintText: 'Enter category name',
                          prefixIcon: Icon(Icons.edit_calendar_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                        'assets/gif/welcome 2.json',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.4,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Animation not found');
                        },
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Center(
                            child: ClipOval(
                              child: ValueListenableBuilder<String>(
                                valueListenable: selectedImagePath,
                                builder: (context, value, child) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      image: DecorationImage(
                                        image: value.isNotEmpty
                                            ? FileImage(File(value))
                                                as ImageProvider
                                            : const AssetImage(
                                                'assets/category/file.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: CheckOut(
                        hintText: 'Update Category',
                        height: screenHeight * 0.06,
                        color: Colors.black,
                        onTap: () async {
                          await updateCategoryInDB();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
