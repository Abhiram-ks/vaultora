import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/productfiles_sub/readmore.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/revanue.dart';

import '../../logistic_stock/logistic.dart';

class RevenueAndLogisticPage extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const RevenueAndLogisticPage({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
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
              lottieFile: 'assets/category/revenue.json',
              title: 'Revenue',
              description:
                  'Revenue is the total income a business earns from its core operations, such as selling products or services, over a specific period. It represents the top line of the income statement and indicates how effectively the company generates income.',
              gradientColors1: const [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 236, 88, 255),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 207, 0, 243),
                Color.fromARGB(255, 0, 0, 0),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const RevanuePage(),));
              },
            ),  SizedBox(height: screenHeight * 0.024),
            CustomContainer(
              lottieFile: 'assets/category/logistics.json',
              title: 'Logistics',
              description:
                  'Logistics refers to the process of planning, implementing, and managing the efficient flow of goods, services, and information from the point of origin to the point of consumption. It ensures that the right products reach the right place at the right time, in the right condition, and at the lowest possible cost.',
              gradientColors1: const [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 0, 0),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 255, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogisticPage(),));
              },
            ),
            ],
          ),
        ),
    );
  }
}