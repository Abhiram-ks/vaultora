import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';
import 'package:vaultora_inventory_app/main%20page/category/purchase/inventory/searchbar.dart';
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
  int _selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBarTwo(
        titleText: 'Purchase Record',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              Searchbarmain(
                hintText: 'Search for Items',
                onSearchPressed: () {},
                onClearPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.05,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: ElevatedButtonField(
                        text: 'Button $index',
                        isSelected: _selectedButtonIndex == index,
                        onPressed: () {
                          setState(() {
                            _selectedButtonIndex = index;
                          });
                          log('Button $index pressed');
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.09),
                  const Expanded(
                    child: FiltaringPrice(
                      label: 'Minimum price',
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  const Expanded(
                    child: FiltaringPrice(
                      label: 'Maximum price',
                    ),
                  ),
                ],
              ),
                  SizedBox(height: screenHeight * 0.01),
                  // AddStyle(data: 'dd', onTap: () {
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Specification(),));
                  // },)
            ],
          ),
        ),
      ),
    );
  }
}
