import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';

import '../../db/models/user/user.dart';
import '../add/add_main/add_products.dart';
import '../add/add_product/add_style.dart';
import '../add/add_product/check_out.dart';


class ShoppingCart extends StatefulWidget {
    final UserModel userDetails; 
  const ShoppingCart({super.key,  required this.userDetails});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const MyAppBar(titleText: 'Sale Products', animationPath:  'assets/category/animation(6).json'),
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
                hintText: 'On-Sale Product',
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