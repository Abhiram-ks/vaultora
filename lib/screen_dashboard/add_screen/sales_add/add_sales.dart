import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';
import '../../../db/helpers/addfunction.dart';
import '../../../db/helpers/salefuction.dart';
import '../../../log/Autotication_singup/validation.dart';
import '../../../log/Autotication_login/phone_validation.dart';
import 'add_multiple_sale.dart';
import '../../records/sales/subfiles_sales/actions_sale.dart';
import '../../records/sales/subfiles_sales/iteam_dropdown.dart';
import '../../records/sales/subfiles_sales/logo_section.dart';
import '../../records/sales/subfiles_sales/sales_stack.dart';
import '../../records/sales/subfiles_sales/success_snackbar.dart';
import '../../records/sales/subfiles_sales/textfiled_sale.dart';


class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _billingNameController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isExpanded = false;
  ValueNotifier<double> totalAmountNotifier = ValueNotifier<double>(0.0);
  Map<AddModel, double> temporaryStock = {};

  @override
  void initState() {
    super.initState();
    tempSaleNotifier.addListener(_calculateTotalPrice);
    initializeStock();
  }

  void initializeStock() {
    for (var product in addBox!.values) {
      double count = double.tryParse(product.itemCount) ?? 0;
      temporaryStock[product] = count;
    }
  }

  void updateTemporaryStock(AddModel product, double quantity) {
    setState(() {
      if (temporaryStock.containsKey(product)) {
        temporaryStock[product] =
            (temporaryStock[product]! - quantity).clamp(0.0, double.infinity);
      }
    });
  }

  @override
  void dispose() {
    tempSaleNotifier.removeListener(_calculateTotalPrice);
    _billingNameController.dispose();
    _addressNameController.dispose();
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
              text: 'Add Sale Products',
              ther: Padding(
                padding: const EdgeInsets.only(top: 94.0),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
                  child: Card(
                    color: whiteColor,
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          color: whiteColor,
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
                                          controller: _billingNameController,
                                          hintText: 'Enter Full Name',
                                          labelText: 'Billing Name',
                                          validate: NameValidator.validate,
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextFieldsale(
                                          controller: _addressNameController,
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
                      return  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopify,
                              size: 40,
                              color: black,
                            ),
                            const Text('No items added to sales list!'),
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
                            child:  Icon(
                              Icons.delete,
                              color: whiteColor,
                              size: 30,
                            ),
                          ),
                          onDismissed: (direction) {
                            final removedProduct =
                                tempSaleNotifier.value[index];
                            final product = removedProduct.product;
                            final quantity = removedProduct.count;

                            if (temporaryStock.containsKey(product)) {
                              double numericQuantity =
                                  double.tryParse(quantity) ?? 0.0;
                              temporaryStock[product] =
                                  temporaryStock[product]! + numericQuantity;
                            }

                            tempSaleNotifier.value =
                                List.from(tempSaleNotifier.value)
                                  ..removeAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${removedProduct.product.itemName} Deleted'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  textColor: whiteColor,
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
                              builder: (context) => MultipleSales(
                                onAdd: (AddModel product, double quality) {
                                  updateTemporaryStock(product, quality);
                                },
                                temporaryStock: temporaryStock,
                              ),
                            ));
                          },
                          checkoutText: '₹ ${totalAmount.toStringAsFixed(2)}',
                          onCheckoutPressed: () {
                            if (tempSaleNotifier.value.isEmpty) {
                              CustomSnackBar.show(
                                context: context,
                                message: 'Add items before proceeding.',
                              );
                              return;
                            }

                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: whiteColor,
                                  title: const Text('Confirm Checkout'),
                                  content: const Text(
                                      'Are you sure you want to proceed to checkout?'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:transParent,
                                            foregroundColor:black,
                                            side:  BorderSide(
                                                color: black,
                                                width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                          ),
                                          child: const Text('Cancel'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              String billingName =
                                                  _billingNameController.text
                                                      .trim();
                                              String address =
                                                  _addressNameController.text
                                                      .trim();
                                              String phoneNumber =
                                                  _phoneController.text.trim();
                                              String totalPrice =
                                                  totalAmountNotifier.value
                                                      .toStringAsFixed(2);

                                              await addSale(
                                                  billingName,
                                                  phoneNumber,
                                                  address,
                                                  totalPrice);
                                              log("Sale added: Name: $billingName, Address: $address, Phone: $phoneNumber, Total Price: ₹$totalPrice");

                                              _billingNameController.clear();
                                              _addressNameController.clear();
                                              _phoneController.clear();
                                              totalAmountNotifier.value = 0.0;

                                              SuccessfullyMessage.show(
                                                context: context,
                                                message:
                                                    'Sale added successfully!',
                                              );
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            } else {
                                              CustomSnackBar.show(
                                                context: context,
                                                message:
                                                    'Please fill all the required fields.',
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:black,
                                            foregroundColor:whiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                          ),
                                          child: const Text('Confirm'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else {
                              CustomSnackBar.show(
                                context: context,
                                message: 'Please fill all the required fields.',
                              );
                            }
                          },
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