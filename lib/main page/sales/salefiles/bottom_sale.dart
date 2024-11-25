import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salefiles/actions_sale.dart';

import '../../../db/functions/addfunction.dart';
import '../../../db/functions/salefuction.dart';
import '../../add/add_product/drowp_down.dart';
import '../add_sales.dart';
import 'iteam_dropdown.dart';
import 'stock_controller.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final ValueNotifier<String?> _selectedCategoryNotifier =ValueNotifier<String?>(null);
  final ValueNotifier<String?> _selectedItemNotifier =ValueNotifier<String?>(null);
  final ValueNotifier<String?> _mrpNotifier = ValueNotifier<String?>('');
  final ValueNotifier<String?> _stockNotifier = ValueNotifier<String?>('0');
  final ValueNotifier<double>  _totalPriceNotifier = ValueNotifier<double>(0.0);

  int stockCount = 0;

  @override
  void dispose() {
    _selectedCategoryNotifier.dispose();
    _selectedItemNotifier.dispose();
    _mrpNotifier.dispose();
    _stockNotifier.dispose();
    _totalPriceNotifier.dispose();
    super.dispose();
  }

  void _updateTotalPrice() {
    double mrp = double.tryParse(_mrpNotifier.value ?? '0') ?? 0;
    _totalPriceNotifier.value = mrp * stockCount;
  }

  void _increaseStock() {
    int maxStock = int.tryParse(_stockNotifier.value ?? '0') ?? 0;
    if (stockCount < maxStock) {
      setState(() {
        stockCount++;
        _stockNotifier.value = stockCount.toString();
        _updateTotalPrice();
      });
    }
  }

  void _decreaseStock() {
    if (stockCount > 1) {
      setState(() {
        stockCount--;
        _stockNotifier.value = stockCount.toString();
        _updateTotalPrice();
      });
    }
  }

void _addToTempSaleList() {
  final category = _selectedCategoryNotifier.value;
  final item = _selectedItemNotifier.value;
  final mrp = _mrpNotifier.value;
  final stock = _stockNotifier.value;
  final totalPrice = _totalPriceNotifier.value;

  if (category != null &&
      item != null &&
      mrp != null &&
      stock != null &&
      totalPrice > 0) {
    tempSaleNotifier.value = [
      ...tempSaleNotifier.value,
      {
        'category': category,
        'item': item,
        'mrp': mrp,
        'stockCount': stockCount,
        'totalPrice': totalPrice,
      }
    ];
    // ignore: invalid_use_of_protected_member
    tempSaleNotifier.notifyListeners();

    log("Item added: $category, $item, $mrp, $stockCount, $totalPrice");
     Navigator.of(context).pop(); 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Text("Item added successfully!"),
        action: SnackBarAction(
          label: 'OK',
          
          onPressed: () {
            
          },
        ),
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0,  MediaQuery.of(context).size.height * 0.01),
        backgroundColor: Colors.lightGreen,
      ),
    );
  } else {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Text("Incomplete data, cannot add to the list."),
        behavior: SnackBarBehavior.floating, 
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0,  MediaQuery.of(context).size.height * 0.85), 
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        height: screenHeight * 0.65,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                elevation: 29,
                child: Container(
                  height: screenHeight * 0.488,
                  width: double.infinity,
                  color: const Color(0xFFE8EDEB),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.04),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: DropDown(
                            height: screenHeight * 0.065,
                            hintText: 'Category',
                            selectedCategoryNotifier: _selectedCategoryNotifier,
                          ),
                        ),
                        ValueListenableBuilder<String?>(
                          valueListenable: _selectedCategoryNotifier,
                          builder: (context, selectedCategory, child) {
                            if (selectedCategory == null ||
                                selectedCategory == 'Select Category') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _selectedItemNotifier.value = null;
                                _mrpNotifier.value = '';
                                _stockNotifier.value = '';
                              });
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05),
                                child: const Text(
                                  'Please select a category first.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              );
                            }
                            final filteredItems = originalItemList
                                .where(
                                    (item) => item.dropDown == selectedCategory)
                                .toList();

                            if (filteredItems.isEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _selectedItemNotifier.value = null;
                                _mrpNotifier.value = '';
                                _stockNotifier.value = '';
                              });
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05),
                                child: const Text(
                                  'No models available for this category.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: DropDownItemName(
                                height: screenHeight * 0.065,
                                hintText: 'Select Model',
                                selectedItemNotifier: _selectedItemNotifier,
                                items: [
                                  'Select Model',
                                  ...filteredItems.map((item) => item.itemName)
                                ],
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<String?>(
                          valueListenable: _selectedItemNotifier,
                          builder: (context, selectedItem, child) {
                            if (selectedItem != null &&
                                selectedItem != 'Select Model') {
                              final selectedItemDetails =
                                  originalItemList.firstWhere(
                                      (item) => item.itemName == selectedItem);

                              _mrpNotifier.value = selectedItemDetails.mrp;
                              _stockNotifier.value =
                                  selectedItemDetails.itemCount;
                            } else {
                              _mrpNotifier.value = '';
                              _stockNotifier.value = '';
                            }
                            _updateTotalPrice();
                            return StockRow(
                              mrp: _mrpNotifier.value,
                              stock: _stockNotifier.value,
                              stockCount: stockCount,
                              onIncrease: _increaseStock,
                              onDecrease: _decreaseStock,
                            );
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.07,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: ValueListenableBuilder<double>(
                            valueListenable: _totalPriceNotifier,
                            builder: (context, totalPrice, child) {
                              return ActionButtons(
                                onAddSalePressed: () {
                                  Navigator.of(context).pop();
                                },
                                onCheckoutPressed: _addToTempSaleList,
                                addSaleText: 'Cancel',
                                checkoutText:
                                    '₹${totalPrice.toStringAsFixed(2)}',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            const Icon(Icons.shopify),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Long press the product you want to delete from the sale.",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "Scroll horizontally to view the items you have added for sale.",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "After checkout, there is no option to edit.",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
          ],
        ),
      ),
    );
  }
}













