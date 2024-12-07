import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';

import '../../../db/helpers/addfunction.dart';
import 'detail_page_zero_stock.dart';
import '../../common/appbar.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:  MyAppBarTwo(titleText: 'Zero Stock',bgColor: inside,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.012),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: addListNotifier,
                builder: (context, List<AddModel> item, child) {
                  final zeroStockItems =
                      item.where((item) => item.itemCount == "0").toList();
                  return Column(
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      if (zeroStockItems.isEmpty)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/category/norecords.json',
                                  width: screenWidth * 0.5,
                                  height: screenHeight * 0.3,
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'No items with Zero Stock !',
                                  style: GoogleFonts.kodchasan(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 129, 129, 129),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                    else
                        SizedBox(
                          height: screenHeight * 0.8,
                          child: ListView.separated(
                            itemCount: zeroStockItems.length,
                           separatorBuilder: (context, index) =>
                                SizedBox(height: screenHeight * 0.01),
                            itemBuilder: (context, index) {
                              final zeroItem = zeroStockItems[index];
                              return ZeroStockDetails(
                                titleText: zeroItem.itemName,
                                descriptionText: zeroItem.description,
                                buttonText: zeroItem.dropDown,
                                imagePath: zeroItem.imagePath,
                              );
                            },
                          
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}