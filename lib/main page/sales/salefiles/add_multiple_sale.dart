import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/actions_sale.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/call_fuction.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/snackbars.dart';

import '../../../db/functions/addfunction.dart';
import '../../../db/models/add/add.dart';
import '../salebasefiles/decoration_list_view.dart';
import '../salebasefiles/search_sale.dart';

class MultipleSales extends StatefulWidget {
  final void Function(AddModel, double)? onAdd;
  final Map<AddModel, double> temporaryStock;

  const MultipleSales({
    super.key,
    required this.onAdd,
    required this.temporaryStock,
  });

  @override
  State<MultipleSales> createState() => _MultipleSalesState();
}

class _MultipleSalesState extends State<MultipleSales> {
  TextEditingController searchController = TextEditingController();
  List<AddModel> filteredList = [];
  int? selectedProductIndex;
  ValueNotifier<int> stockLevel = ValueNotifier<int>(0);
  ValueNotifier<String> checkoutText = ValueNotifier<String>('₹ 0.00');
  ValueNotifier<double> quantityNotifier = ValueNotifier<double>(0);

  int count = 0;
  AddModel? selectedProduct;

  @override
  void initState() {
    super.initState();
    filteredList = addListNotifier.value;
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = addListNotifier.value;
        selectedProductIndex = null;
        stockLevel.value = 0;
      });
    } else {
      setState(() {
        filteredList = addListNotifier.value
            .where((item) =>
                item.itemName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        selectedProductIndex = null;
        stockLevel.value = 0;
      });
    }
  }

  void handleProductClick(int index) {
    setState(() {
      selectedProductIndex = index;
      selectedProduct = filteredList[index];
      stockLevel.value = widget.temporaryStock[selectedProduct!]!.toInt();

      count = stockLevel.value > 0 ? 1 : 0;

      double mrp = double.tryParse(filteredList[index].mrp) ?? 0;
      checkoutText.value = '₹ ${(count * mrp).toStringAsFixed(2)}';
    });
  }

  void incrementCount() {
    setState(() {
      if (count < stockLevel.value) {
        count++;
        double mrp = selectedProductIndex != null
            ? double.tryParse(filteredList[selectedProductIndex!].mrp) ?? 0
            : 0;
        checkoutText.value = '₹ ${(count * mrp).toStringAsFixed(2)}';
      }
    });
  }

  void decrementCount() {
    setState(() {
      if (count > 1) {
        count--;
        double mrp = selectedProductIndex != null
            ? double.tryParse(filteredList[selectedProductIndex!].mrp) ?? 0
            : 0;
        checkoutText.value = '₹ ${(count * mrp).toStringAsFixed(2)}';
      }
    });
  }

void onCheckoutPressed() {
  if (selectedProductIndex != null) {
    final selectedProduct = filteredList[selectedProductIndex!];
    final availableStock = widget.temporaryStock[selectedProduct] ?? 0;

    if (availableStock == 0) {
      CustomDialog.showStockAlertSnackBar(
        context,
        productName: selectedProduct.itemName,
      );
      return;
    }

    if (widget.temporaryStock.containsKey(selectedProduct)) {
      double availableStock = widget.temporaryStock[selectedProduct]!;
      if (availableStock > 0) {
        widget.temporaryStock[selectedProduct] = availableStock - count;
      }
    }

    tempSaleNotifier.value.add(
      SaleProduct(
        product: selectedProduct,
        count: count.toString(),
        price: checkoutText.value,
      ),
    );

    // ignore: invalid_use_of_protected_member
    tempSaleNotifier.notifyListeners();

    log('Product added to sales list:');
    log('Name: ${selectedProduct.itemName}');
    log('Count: ${count.toString()}');
    log('Price: ${checkoutText.value}');

    setState(() {
      selectedProductIndex = null;
      searchController.clear();
      count = 0;
      stockLevel.value = 0;
      checkoutText.value = '₹ 0.00';
    });

    CustomSnackBar.showSuccessSnackBar(context, selectedProduct.itemName);
  } else {
    CustomSnackBar.showErrorSnackBar(context);
  }
}


  void updateTemporaryStock(AddModel product, double quantity) {
    setState(() {
      if (widget.temporaryStock.containsKey(product)) {
        widget.temporaryStock[product] =
            (widget.temporaryStock[product]! - quantity)
                .clamp(0.0, double.infinity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBarTwo(titleText: 'Add Sale'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: SearchField(
                searchController: searchController,
                filterSearchResults: filterSearchResults,
                screenWidth: screenWidth,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.6,
              child: ValueListenableBuilder<List<AddModel>>(
                valueListenable: addListNotifier,
                builder: (context, addList, child) {
                  if (filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/category/norecords.json',
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.3,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'No Products found!',
                            style: GoogleFonts.kodchasan(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: selectedProductIndex == null
                          ? filteredList.length
                          : 1,
                      itemBuilder: (context, index) {
                        final actualIndex = selectedProductIndex ?? index;
                        final item = filteredList[actualIndex];
                        return Column(
                          children: [
                            SizedBox(height: screenHeight * 0.01),
                            MultipleSateFiled(
                              imagePath: item.imagePath,
                              titleText: item.itemName,
                              descriptionText: item.description,
                              buttonText: item.dropDown,
                              price: item.mrp,
                              onTap: () => handleProductClick(actualIndex),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Card(
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Available Stock',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable: stockLevel,
                                builder: (context, stock, child) {
                                  return Column(
                                    children: [
                                      Text(
                                        'Stock Level: ${stock.toInt()}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: decrementCount,
                          ),
                          Container(
                            color: Colors.grey[300],
                            width: 50,
                            child: Center(
                              child: Text(
                                '$count',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: incrementCount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ValueListenableBuilder<String>(
                valueListenable: checkoutText,
                builder: (context, checkoutValue, child) {
                  return ActionButtons(
                    onAddSalePressed: () {
                      Navigator.of(context).pop();
                    },
                    onCheckoutPressed: onCheckoutPressed,
                    addSaleText: 'Return',
                    checkoutText: checkoutValue,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
