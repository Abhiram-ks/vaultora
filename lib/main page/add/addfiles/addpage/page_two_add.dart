import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/main%20page/add/addfiles/add_product/add_product.dart';
import 'package:vaultora_inventory_app/main%20page/add/addfiles/add_sale/add_sales.dart';
import 'package:vaultora_inventory_app/main%20page/add/productfiles_sub/readmore.dart';
import 'package:vaultora_inventory_app/main%20page/profile/DialogBox/category_field.dart';
class AddProductPage extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final UserModel userDetails;

  const AddProductPage({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.024),
            CustomContainer(
              lottieFile: 'assets/category/truck.json',
              title: 'Add Product',
              description:
                  'Seamlessly add items with details like name, category, price, and quantity. It ensures accuracy through photo uploads, error validation, and real-time updates, while its intuitive design enhances efficiency and organization.',
              gradientColors1: const [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 0, 140, 255),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 0, 157, 255),
                Color.fromARGB(255, 0, 0, 0),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  AddProducts(userDetails: userDetails,),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.024),
            CustomContainer(
              lottieFile: 'assets/gif/twoanimation.json',
              title: 'Add Category',
              description:
                  'Inventory by allowing users to create, edit, or delete product categories. It ensures better organization, improves searchability, and simplifies stock management with an intuitive interface.',
              gradientColors1: const [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 145, 0),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 255, 149, 0),
                Color.fromARGB(255, 0, 0, 0),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                CategoryBox.showAddCategoryDialog(context, userDetails.id);
              },
            ),
            SizedBox(height: screenHeight * 0.024),
            CustomContainer(
              lottieFile: 'assets/category/add_sales.json',
              title: 'Add Sales',
              description:
                  'Tracking transactions, allowing users to record sales with details such as product, quantity, date, and price. It ensures accurate inventory updates, streamlines revenue tracking, and provides real-time insights into sales performance, enhancing overall business efficiency.',
              gradientColors1: const [
                Color.fromARGB(255, 15, 53, 0),
                Color.fromARGB(255, 193, 255, 195),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 168, 250, 170),
                Color.fromARGB(255, 17, 85, 0),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddSales(),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.024),
          ],
        ),
      ),
    );
  }
}