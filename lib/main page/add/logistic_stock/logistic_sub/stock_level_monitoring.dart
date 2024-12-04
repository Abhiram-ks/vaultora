
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class StockLevelMonitoring extends StatelessWidget {
  final String titleText;
  final String imagePath;
  final String statusText;
  final int productStock;
  final int saleStock;
  final int totalStock;

  const StockLevelMonitoring({
    super.key,
    required this.titleText,
    required this.imagePath,
    required this.statusText,
    required this.productStock,
    required this.saleStock,
    required this.totalStock,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Container(
            color: const Color(0xFFE8EDEB),
            width: double.infinity,
            height: screenHeight * 0.15,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.shopping_bag_rounded,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: imagePath.isNotEmpty
                                  ? FileImage(File(imagePath)) as ImageProvider
                                  : const AssetImage(
                                      'assets/welcome/main image.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Material(
                        shadowColor: Colors.black,
                        elevation: 10,
                        child: Container(
                          height: screenHeight * 0.14,
                          color: Colors.white,
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titleText,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  'Remaining Stock: $productStock',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  'Sale Stock: $saleStock',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  'Total Stock: $totalStock',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 196, 196, 196),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    statusText,
                                    style: TextStyle(
                                      color: statusText == "In Stock"
                                          ? Colors.green
                                          : redColor,
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(statusText == "In Stock"
                ? Icons.shopping_cart_sharp
                : Icons.remove_shopping_cart_sharp,
                color: statusText == "In Stock"
                ?Colors.green:redColor,
                size: 18,
                ),
          ),
        ],
      ),
    );
  }
}