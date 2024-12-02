import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/sales_record/sale_class/list_screen.dart/sale_record.dart';
import 'package:vaultora_inventory_app/main%20page/add/ADD/add_sale/add_sales.dart';
import 'package:vaultora_inventory_app/main%20page/add/ADD/logistic_stock/logistic.dart';
import 'package:vaultora_inventory_app/main%20page/add/ADD/revanue/revanue.dart';

import '../../add/ADD/add_product/add_products.dart';
import '../../Inventory/product_record/record_product/record_inventory.dart';
import '../../profile/DialogBox/category_field.dart';
import '../../profile/modification/profile_page.dart';


class AppDrawer extends StatefulWidget {
  final UserModel userDetails;

  const AppDrawer({super.key, required this.userDetails});

  @override
  // ignore: library_private_types_in_public_api
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 110, 110, 110).withOpacity(0.7),
      elevation: 8,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 47, 47, 47).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.5,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.transparent,
                width: double.infinity,
                height: screenHeight * 0.07,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    width: double.infinity,
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.lerp(const Color.fromARGB(255, 0, 0, 0), const Color.fromARGB(255, 0, 140, 255), _controller.value)!,
                          Color.lerp(const Color.fromARGB(255, 255, 0, 0), const Color.fromARGB(255, 0, 255, 8), _controller.value)!,
                          Color.lerp(const Color.fromARGB(255, 246, 255, 0), const Color.fromARGB(255, 0, 0, 0), _controller.value)!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          Container(
                            width: screenWidth * 0.25,
                            height: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: widget.userDetails.imagePath != null &&
                                      widget.userDetails.imagePath!.isNotEmpty
                                  ? DecorationImage(
                                      image: FileImage(File(widget.userDetails.imagePath!)),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    )
                                  : null,
                            ),
                            child: widget.userDetails.imagePath == null ||
                                    widget.userDetails.imagePath!.isEmpty
                                ? const Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xFF1E1E2C),
                                      size: 50,
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            "Hello, ${widget.userDetails.username}!",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.userDetails.email,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
               SizedBox(
                      height: screenHeight * 0.02,
                    ),
              SizedBox(
                width: double.infinity,
                height: screenHeight*0.62,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: screenHeight*0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text(
                          'Inventory',
                          style: GoogleFonts.kodchasan(
                            fontSize: 17,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.01,),
                        CustomListTile(
                          iconData: Icons.shopping_bag_sharp,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProducts(userDetails: widget.userDetails,),));
                          },
                          text: 'Add  product',
                        ),SizedBox(height: screenHeight*0.004,),
                            CustomListTile(
                          iconData: Icons.shopify_sharp,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const AddSales(),));
                          },
                          text: 'Add sales',
                        ),SizedBox(height: screenHeight*0.004,),
                           CustomListTile(
                          iconData: Icons.bar_chart_rounded,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const RevanuePage(),));
                          },
                          text: 'Revanue',
                        ),SizedBox(height: screenHeight*0.004,),
                           CustomListTile(
                          iconData: Icons.manage_search_rounded,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const LogisticPage()));
                          },
                          text: 'Stock Level',
                        ),SizedBox(height: screenHeight*0.004,),
                       const Divider()
                       ,SizedBox(height: screenHeight*0.004,),
                        Text(
                          'Users & accounts',
                          style: GoogleFonts.kodchasan(
                            fontSize: 17,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),SizedBox(height: screenHeight*0.004,),
                           CustomListTile(
                          iconData: Icons.person,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(userDetails: widget.userDetails,),));
                          },
                          text: 'Profile',
                        ),SizedBox(height: screenHeight*0.004,),
                         CustomListTile(
                          iconData: Icons.policy_rounded,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(userDetails: widget.userDetails,),));
                          },
                          text: 'Privacy Policy',
                        ),SizedBox(height: screenHeight*0.004,),
                        CustomListTile(
                          iconData: Icons.file_copy_rounded,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(userDetails: widget.userDetails,),));
                          },
                          text: 'Terms & Conditions',
                        ),SizedBox(height: screenHeight*0.004,),
                       const Divider()
                       ,SizedBox(height: screenHeight*0.004,),
                       Text(
                          'Special features',
                          style: GoogleFonts.kodchasan(
                            fontSize: 17,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),SizedBox(height: screenHeight*0.004,),
                        CustomListTile(
                          iconData: Icons.dataset_linked,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PurchaseRecord(),));
                          },
                          text: 'Product Data',
                        ),SizedBox(height: screenHeight*0.004,),
                         CustomListTile(
                          iconData: Icons.monetization_on,
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SalesData(),));
                          },
                          text: 'Sales Data',
                        ),SizedBox(height: screenHeight*0.004,),
                              CustomListTile(
                          iconData: Icons.category_outlined,
                          onTap: (){
                            CategoryBox.showAddCategoryDialog(context, widget.userDetails.id);
                          },
                          text: 'Add Category',
                        ),SizedBox(height: screenHeight*0.1,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}



class CustomListTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String text;

  const CustomListTile({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: screenHeight * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData, color: Colors.white),
            SizedBox(width: screenWidth * 0.04),
            Text(
              text,
              style: GoogleFonts.kodchasan(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}