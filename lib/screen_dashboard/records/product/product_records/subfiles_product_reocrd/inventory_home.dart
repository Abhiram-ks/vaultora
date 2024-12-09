import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/product_records/subfiles_product_reocrd/inventory_card.dart';

import '../product_record.dart';
import '../../../sales/sales_record/sale_record.dart';
import '../../../../logistic/logistic.dart';

class InventoryHome extends StatelessWidget {
  const InventoryHome({super.key});

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
  height: screenHeight / 5,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
      InventoryFunction(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => const PurchaseRecord(),));
        },
        imagePath: 'assets/category/animation(6).json',
        title: 'Purchase',
        subtitle: 'SUPPLY SUMMARY',
        color: const Color.fromARGB(255, 125, 185, 203),
      ),
      SizedBox(width: screenWidth * 0.03),
      InventoryFunction(
        onTap: () {
          
        },
        imagePath: 'assets/category/animation(2).json',
        title: 'Revenue',
        subtitle: 'PROFIT TRACKER',
        color: const Color.fromARGB(255, 125, 185, 203),
      ),
      SizedBox(width: screenWidth * 0.03),
      InventoryFunction(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SalesData(),));
        },
        imagePath: 'assets/gif/twoanimation.json',
        title: 'Sales',
        subtitle: 'INCOME INSIGHTS',
        color: const Color.fromARGB(255, 125, 185, 203),
      ),
      SizedBox(width: screenWidth * 0.03),
      InventoryFunction(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogisticPage(),));
        },
        imagePath: 'assets/gif/welcome one.json',
        title: 'Logistic ',
        subtitle: 'INVENTORY OVERVIEW',
        color: const Color.fromARGB(255, 250, 246, 21),
      ),
    ],
  ),
);
  }
}