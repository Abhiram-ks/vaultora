import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/actions_sale.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/snackbars.dart';

import '../../../db/functions/addfunction.dart';
import '../../../db/models/add/add.dart';

class MultipleSales extends StatefulWidget {
  const MultipleSales({super.key});

  @override
  State<MultipleSales> createState() => _MultipleSalesState();
}

class _MultipleSalesState extends State<MultipleSales> {
  TextEditingController searchController = TextEditingController();
  List<AddModel> filteredList = [];
  int? selectedProductIndex;
  ValueNotifier<int> stockLevel = ValueNotifier<int>(0);
  ValueNotifier<String> checkoutText = ValueNotifier<String>('₹ 0.00');

  int count = 0;

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
      stockLevel.value = int.tryParse(filteredList[index].itemCount) ?? 0;
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
                                  return Text(
                                    'Stock Level: $stock',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  );
                                },
                              ),
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

class CounterWidget extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterWidget({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onDecrement,
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
          onPressed: onIncrement,
        ),
      ],
    );
  }
}

class MultipleSateFiled extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onSwipe;
  final String titleText;
  final String descriptionText;
  final String buttonText;
  final String imagePath;
  final String price;

  const MultipleSateFiled({
    super.key,
    this.onTap,
    this.onSwipe,
    required this.titleText,
    required this.descriptionText,
    required this.buttonText,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      onHorizontalDragEnd: (details) {
        if (onSwipe != null) onSwipe!();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
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
                        child: Icon(Icons.shopify),
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
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                descriptionText,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 95, 95, 95),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  const Icon(Icons.local_print_shop),
                                  SizedBox(width: screenWidth * 0.02),
                                  const Text(
                                    'Price',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 95, 95, 95),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 95, 95, 95),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
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
                                  buttonText,
                                  style: const TextStyle(
                                    color: Colors.black,
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
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) filterSearchResults;
  final double screenWidth;

  const SearchField({
    super.key,
    required this.searchController,
    required this.filterSearchResults,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.07,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: filterSearchResults,
              decoration: const InputDecoration(
                hintText: 'Search for Items',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF68C5CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
