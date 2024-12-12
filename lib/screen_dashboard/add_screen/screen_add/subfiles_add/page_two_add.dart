import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/Category_add/category_add.dart';
import '../../../common/gradient_add_container.dart';
import '../../product_add/add_product.dart';
import '../../sales_add/add_sales.dart';

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
                Color.fromARGB(255, 125, 185, 203),
                Color.fromARGB(255, 33, 80, 94),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 188, 229, 241),
                Color.fromARGB(255, 59, 140, 164),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddProducts(
                      userDetails: userDetails,
                    ),
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
                Color.fromARGB(255, 2, 72, 92),
                Color.fromARGB(255, 179, 230, 245)
              ],
              gradientColors2: const [
                Color.fromARGB(255, 59, 140, 164),
                Color.fromARGB(255, 180, 225, 238),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      AddCategoryDialog(userId: userDetails.id),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.024),
            CustomContainer(
              lottieFile: 'assets/category/add_sales.json',
              title: 'Add Sales',
              description:
                  'Tracking transactions, allowing users to record sales with details such as product, quantity, date, and price. It ensures accurate inventory updates, streamlines revenue tracking, and provides real-time insights into sales performance, enhancing overall business efficiency.',
              gradientColors1: const [
                Color.fromARGB(255, 59, 140, 164),
                Color.fromARGB(255, 40, 98, 116),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 180, 225, 238),
                Color.fromARGB(255, 125, 185, 203),
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
