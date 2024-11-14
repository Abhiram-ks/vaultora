import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/inventory/searchbar.dart';
import '../../../../db/functions/addfunction.dart';
import '../../../../db/models/add/add.dart';
import '../../../add/add_product/add_style.dart';
import '../detailPurchase/specification.dart';
import '../inventory/button_fileds.dart';
import '../inventory/filtaring_price.dart';

class PurchaseRecord extends StatefulWidget {
  const PurchaseRecord({super.key});

  @override
  State<PurchaseRecord> createState() => _PurchaseRecordState();
}

class _PurchaseRecordState extends State<PurchaseRecord> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBarTwo(
        titleText: 'Inventory Record',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            // Search bar section
            Searchbarmain(
              hintText: 'Search for Items',
              onSearchPressed: () {},
              onClearPressed: () {},
            ),
            Row(
              children: [
                Container(

                )
              ],
              // children: [
               
              //   SizedBox(width: screenWidth * 0.02),
              //   const Expanded(
              //     child: FiltaringPrice(
              //       label: 'Minimum price',
              //     ),
              //   ),
              //   SizedBox(width: screenWidth * 0.05),
              //   const Expanded(
              //     child: FiltaringPrice(
              //       label: 'Maximum price',
              //     ),
              //   ),
              // ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: ValueListenableBuilder<List<AddModel>>(
                valueListenable: addListNotifier,
                builder: (context, addList, child) {
                  return ListView.builder(
                    itemCount: addList.length,
                    itemBuilder: (context, index) {
                      final item = addList[index];
                      return Column(
                        children: [
                          AddStyle(
                            imagePath: item.imagePath,
                            titleText: item.itemName,
                            descriptionText: item.description,
                            buttonText: item.dropDown,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Specification(item: item),
                              ));
                            },
                          ),
                          SizedBox(height: screenHeight * 0.01),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
