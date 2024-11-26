import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salefiles/logo_section_decoration.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salefiles/sales_stack.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salefiles/textfiled_sale.dart';
import '../../db/functions/salefuction.dart';
import '../../log/LoginAutotications/validation.dart';
import '../../log/logAutetication/phone_validation.dart';
import 'salefiles/actions_sale.dart';
import 'salefiles/bottom_sale.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _BillingNameController = TextEditingController();
  final TextEditingController _AddressNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isExpanded = false;
  ValueNotifier<double> totalAmountNotifier = ValueNotifier<double>(0.0);



  @override
  void initState() {
    super.initState();
    tempSaleNotifier.addListener(_calculateTotalPrice); 
  }

  @override
  void dispose() {
    tempSaleNotifier.removeListener(_calculateTotalPrice);
    _BillingNameController.dispose();
    _AddressNameController.dispose();
    _phoneController.dispose();
    totalAmountNotifier.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    double total = 0.0;

    for (var sale in tempSaleNotifier.value) {
      String priceString = sale.price.replaceAll('₹', '').trim();
      double itemPrice = double.tryParse(priceString) ?? 0.0;
      total += itemPrice;
    }

    if (totalAmountNotifier.value != total) {
      totalAmountNotifier.value = total; 
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SalesStack(
              ther: Padding(
                padding: const EdgeInsets.only(top: 94.0),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
                  child: Card(
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Column(
                            children: [
                              LogoSection(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                firstChild: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        CustomTextFieldsale(
                                          controller: _BillingNameController,
                                          hintText: 'Enter Full Name',
                                          labelText: 'Billing Name',
                                          validate: NameValidator.validate,
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextFieldsale(
                                          controller: _AddressNameController,
                                          hintText: 'Enter Address',
                                          labelText: 'Billing Address',
                                          validate: VentureValidator.validate,
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextFieldsalePhone(
                                          controller: _phoneController,
                                          hintText: '',
                                          labelText: 'Phone Number',
                                          validate:
                                              PhoneNumberValidator.validate,
                                        ),
                                        const SizedBox(height: 16)
                                      ],
                                    ),
                                  ),
                                ),
                                secondChild: const SizedBox.shrink(),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
              child: SizedBox(
                height: screenHeight * 0.6,
                child: ValueListenableBuilder<List<SaleProduct>>(
                  valueListenable: tempSaleNotifier,
                  builder: (context, saleList, child) {
                    if (saleList.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopify,
                              size: 40,
                            ),
                            Text('No items added to sales list!'),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: saleList.length,
                      itemBuilder: (context, index) {
                        final item = saleList[index];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            color: Colors.red[200],
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          onDismissed: (direction) {
                            final removedProduct =
                                tempSaleNotifier.value[index];

                            tempSaleNotifier.value =
                                List.from(tempSaleNotifier.value)
                                  ..removeAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${removedProduct.product.itemName} Deleted'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    tempSaleNotifier.value =
                                        List.from(tempSaleNotifier.value)
                                          ..insert(index, removedProduct);
                                  },
                                ),
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          },
                          key: ValueKey(tempSaleNotifier.value[index]),
                          child: Column(
                            children: [
                              ShowSaleAdded(
                                titleText: item.product.itemName,
                                descriptionText: item.product.description,
                                buttonText: item.product.dropDown,
                                imagePath: item.product.imagePath,
                                price: item.price,
                                badgeText: item.count,
                              ),
                              SizedBox(
                                height: screenHeight * 0.015,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '<-- Swipe to delete.      ',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Center(
                child: Column(
                  children: [
                    ValueListenableBuilder<double>(
                      valueListenable: totalAmountNotifier,
                      builder: (context, totalAmount, child) {
                        return ActionButtons(
                          addSaleText: 'Add Sale',
                          onAddSalePressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MultipleSales(),
                            ));
                          },
                          checkoutText: '₹ ${totalAmount.toStringAsFixed(2)}',
                          onCheckoutPressed: () {},
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Scroll vertically to view the items you have added for sale.",
                      style: TextStyle(fontSize: 10),
                    ),
                    const Text(
                      "After checkout, there is no option to edit.",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowSaleAdded extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onSwipe;
  final String titleText;
  final String descriptionText;
  final String buttonText;
  final String imagePath;
  final String price;
  final String badgeText;

  const ShowSaleAdded({
    super.key,
    this.onTap,
    this.onSwipe,
    required this.titleText,
    required this.descriptionText,
    required this.buttonText,
    required this.imagePath,
    required this.price,
    required this.badgeText,
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
                                    ? FileImage(File(imagePath))
                                        as ImageProvider
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
                                  Row(
                                    children: [
                                      const Icon(Icons.local_print_shop),
                                      SizedBox(width: screenWidth * 0.02),
                                      const Text(
                                        'Price',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 95, 95, 95),
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
                                          color:
                                              Color.fromARGB(255, 95, 95, 95),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
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
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscountSection extends StatelessWidget {
  final String? selectedDiscountType;
  final Function(String?) onTypeSelected;
  final TextEditingController discountController;
  final VoidCallback onDiscountChanged;

  const DiscountSection({
    super.key,
    required this.selectedDiscountType,
    required this.onTypeSelected,
    required this.discountController,
    required this.onDiscountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          hint: const Text('Apply Discount'),
          value: selectedDiscountType,
          items: const [
            DropdownMenuItem(
                value: "percentage", child: Text("Percentage (%)")),
            DropdownMenuItem(value: "fixed", child: Text("Fixed (₹)")),
          ],
          onChanged: (value) {
            onTypeSelected(value);
          },
        ),
        if (selectedDiscountType != null) ...[
          TextField(
            controller: discountController,
            onChanged: (_) => onDiscountChanged(),
            decoration: InputDecoration(
              labelText: selectedDiscountType == "percentage"
                  ? "Discount (%)"
                  : "Discount (₹)",
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ],
    );
  }
}
