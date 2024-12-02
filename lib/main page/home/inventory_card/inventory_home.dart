import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/product_record/record_product/record_inventory.dart';
import 'package:vaultora_inventory_app/main%20page/add/ADD/logistic_stock/logistic.dart';
import 'package:vaultora_inventory_app/main%20page/home/inventory_card/inventory_card.dart';

import '../../Inventory/sales_record/sale_class/list_screen.dart/sale_record.dart';

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
        color: const Color.fromARGB(255, 174, 222, 246),
      ),
      SizedBox(width: screenWidth * 0.03),
      InventoryFunction(
        onTap: () {
          
        },
        imagePath: 'assets/category/animation(2).json',
        title: 'Revenue',
        subtitle: 'PROFIT TRACKER',
        color: const Color.fromARGB(255, 226, 212, 255),
      ),
      SizedBox(width: screenWidth * 0.03),
      InventoryFunction(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SalesData(),));
        },
        imagePath: 'assets/gif/twoanimation.json',
        title: 'Sales',
        subtitle: 'INCOME INSIGHTS',
        color: const Color.fromARGB(255, 245, 246, 174),
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