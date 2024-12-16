import 'package:flutter/material.dart';
import '../../../logistic/logistic.dart';
import '../../../common/gradient_add_container.dart';
import '../../../revenue/revanue.dart';

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
              lottieFile: 'assets/gif/revenueandlogisic.json',
              title: 'Revenue',
              description:
                  'Revenue is the total income a business earns from its core operations, such as selling products or services, over a specific period. It represents the top line of the income statement and indicates how effectively the company generates income.',
              gradientColors1: const [
                Color.fromARGB(255, 13, 73, 92),
                Color.fromARGB(255, 67, 127, 146),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 17, 91, 112),
                Color.fromARGB(255, 11, 81, 102),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RevanuePage(),
                ));
              },
            ),
            SizedBox(height: screenHeight * 0.024),
            CustomContainer(
              lottieFile: 'assets/gif/logistics.json',
              title: 'Logistics',
              description:
                  'Logistics refers to the process of planning, implementing, and managing the efficient flow of goods, services, and information from the point of origin to the point of consumption. It ensures that the right products reach the right place at the right time, in the right condition, and at the lowest possible cost.',
              gradientColors1: const [
                Color.fromARGB(255, 59, 140, 164),
                Color.fromARGB(255, 125, 185, 203),
              ],
              gradientColors2: const [
                Color.fromARGB(255, 29, 66, 77),
                Color.fromARGB(255, 40, 98, 116),
              ],
              right: 10.0,
              bottom: 10.0,
              lottieSize: 102.0,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LogisticPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
