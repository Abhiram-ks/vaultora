import 'dart:ffi';

import 'package:flutter/material.dart';
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
  String? selectedDiscountType;
  TextEditingController discountController = TextEditingController();
  ValueNotifier<double> totalAmountNotifier = ValueNotifier<double>(0.0);
  ValueNotifier<double> discountedAmountNotifier = ValueNotifier<double>(0.0);

  void calculateTotalAmount() {
    double total = 0.0;
    for (var sale in tempSaleNotifier.value) {
      total += sale['totalPrice'];
    }
    totalAmountNotifier.value = total;
    applyDiscount();
  }

  void applyDiscount() {
    double totalAmount = totalAmountNotifier.value;
    double discountedAmount = totalAmount;
    if (discountController.text.isNotEmpty) {
      double discountValue = double.tryParse(discountController.text) ?? 0.0;
      if (selectedDiscountType == "percentage") {
        discountedAmount = totalAmount - (totalAmount * discountValue / 100);
      } else if (selectedDiscountType == "fixed") {
        discountedAmount = totalAmount - discountValue;
      }
      discountedAmount = discountedAmount < 0 ? 0 : discountedAmount;
    }
    discountedAmountNotifier.value = discountedAmount;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
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
                                           validate: PhoneNumberValidator.validate,
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
                height: screenHeight * 0.52,
                child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: tempSaleNotifier,
                  builder: (context, tempSales, _) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      calculateTotalAmount();
                    });
                    if (tempSales == null || tempSales.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.shopify, size: 30),
                            Text("No items added yet."),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: tempSales.length,
                      itemBuilder: (context, index) {
                        final sale = tempSales[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Card(
                            color: Colors.deepPurple[50],
                            elevation: 4.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${sale['category']} - ${sale['item']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        "Stock: ${sale['stockCount']} | Price: ₹${sale['totalPrice']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      height: screenHeight * 0.05,
                                      width: screenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenHeight * 0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4.0,
                                    right: 4.0,
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.delete_forever_rounded),
                                      onPressed: () {
                                        tempSales.removeAt(index);
                                        tempSaleNotifier.value = [...tempSales];
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                    DiscountSection(
                      selectedDiscountType: selectedDiscountType,
                      discountController: discountController,
                      onTypeSelected: (value) {
                        setState(() {
                          selectedDiscountType = value;
                          discountController.clear();
                          applyDiscount();
                        });
                      },
                      onDiscountChanged: () {
                        applyDiscount();
                      },
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<double>(
                      valueListenable: discountedAmountNotifier,
                      builder: (context, totalAmount, _) {
                        return ActionButtons(
                          addSaleText: 'Add Sale',
                          onAddSalePressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return const BottomSheetContent();
                              },
                            );
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
