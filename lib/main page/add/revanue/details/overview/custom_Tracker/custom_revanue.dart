


import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/revanue/details/reve_sub_class/totalreve_card.dart';

class Customisation extends StatelessWidget {
  const Customisation({super.key});

 
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            EarningsCard(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              title: 'Date-Specific Income',
              amount: '₹ 1000000000.00',
              icon: Icons.arrow_upward,
              iconColor: Colors.green,
              percentageText: '+25.45%',
            ),
          ],
        ),
      ),
    );
  }
}
