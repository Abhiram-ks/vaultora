import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_main_pages/add_products.dart';
import '../../../db/models/user/user.dart';
import '../../profile/DialogBox/category_field.dart';
import '../../sales/add_sales.dart';
import '../add_product/appbar.dart';
import '../add_product/readmore.dart';


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
          animationPath: 'assets/category/animation(6).json'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.024),
              CustomContainer(
                lottieFile: 'assets/category/truck.json',
                title: 'Add Product',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1: const [
                   Color.fromARGB(255, 0, 30, 54),
                   Color.fromARGB(255, 88, 180, 255),
                ],
                gradientColors2: const [
                   Color.fromARGB(255, 0, 133, 243),
                    Color.fromARGB(255, 215, 237, 255),
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
                onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                AddProducts(userDetails: widget.userDetails)
                ));
                },
                
              ),
              SizedBox(height: screenHeight * 0.024),
              CustomContainer(
                lottieFile: 'assets/gif/twoanimation.json',
                title: 'Add Category',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1: const[
                  
                  Color.fromARGB(255, 80, 64, 0),
                  Color.fromARGB(255, 255, 153, 0),
                ],
                gradientColors2: const[
                  Color.fromARGB(255, 255, 227, 184),
                  Color.fromARGB(255, 235, 151, 61),
                
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
               onTap: (){
                  CategoryBox.showAddCategoryDialog(context, widget.userDetails.id);
               
                },
              ),
              SizedBox(height: screenHeight * 0.024),
              CustomContainer(
                lottieFile: 'assets/category/add_sales.json',
                title: 'Add Sales',
                description: 'This is a description about adding sales and its functionality.',
                gradientColors1:const [
                   Color.fromARGB(255, 15, 53, 0),
                   Color.fromARGB(255, 193, 255, 195)
                ],
                gradientColors2: const[
                   Color.fromARGB(255, 168, 250, 170),
                   Color.fromARGB(255, 0, 71, 2)
                ],
                right: 10.0,
                bottom: 10.0,
                lottieSize: 102.0,
                onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                const AddSales(


                ),
                ));
                },
              ),
              SizedBox(height: screenHeight * 0.024),
            ],
          ),
        ),
      ),
    );
  }
}
