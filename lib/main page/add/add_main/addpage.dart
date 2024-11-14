import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_main/add_products.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/add_style.dart';

import '../../../db/models/user/user.dart';
import '../add_product/appbar.dart';
import '../add_product/check_out.dart';

class Addpage extends StatefulWidget {
    final UserModel userDetails; 
  const Addpage({super.key, required this.userDetails});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBar(
        titleText: 'Add to catalog',
        animationPath: 'assets/gif/twoanimation.json',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.024),
               AddStyle(
                buttonText: 'dlk',
                descriptionText: 'ldk',
                imagePath: '',
                titleText: 'd'
                ,onTap: () {
                
              },),
              SizedBox(height: screenHeight * 0.024),
              CheckOut(
                color: const Color.fromARGB(255, 33, 63, 77),
                height: screenHeight * 0.06,
                hintText: 'Add Product',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  AddProducts(userDetails: widget.userDetails),));
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              CheckOut(
                color: const Color.fromARGB(255, 37, 110, 10),
                height: screenHeight * 0.06,
                hintText: 'Check Out',
                onTap: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}