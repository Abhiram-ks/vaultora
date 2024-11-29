import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/log/LoginAutotications/validation.dart';
import 'package:vaultora_inventory_app/log/logAutetication/phone_validation.dart';
import 'package:vaultora_inventory_app/main%20page/category/list_sale/sale_class/subclass_sale/edit_sale.dart';
import 'package:vaultora_inventory_app/main%20page/category/list_sale/sale_class/subclass_sale/time_date.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/sales_stack.dart';
import 'package:vaultora_inventory_app/main%20page/sales/salebasefiles/textfiled_sale.dart';

class SalesStackWidget extends StatefulWidget {
  final ValueNotifier<String> billingNameNotifier;
  final dynamic screenWidth;
  final dynamic screenHeight;
  final dynamic saledDetails;
  final dynamic formKey;
  final ValueNotifier<String> addressNameNotifier;
  final ValueNotifier<String> phoneNotifier;
  final bool isExpanded;
  final String formattedDate;
  final String formattedTime;
  final BuildContext ctx;
  final VoidCallback updateExpand;

  const SalesStackWidget({
    required this.billingNameNotifier,
    required this.screenWidth,
    required this.screenHeight,
    required this.saledDetails,
    required this.formKey,
    required this.addressNameNotifier,
    required this.phoneNotifier,
    required this.isExpanded,
    required this.formattedDate,
    required this.formattedTime,
    required this.ctx,
    required this.updateExpand,
    super.key,
  });

  @override
  State<SalesStackWidget> createState() => _SalesStackWidgetState();
}

class _SalesStackWidgetState extends State<SalesStackWidget> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
    widget.updateExpand();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.billingNameNotifier,
      builder: (context, value, child) {
        return SalesStack(
          text: '$value Sales Record',
          ther: Padding(
            padding: EdgeInsets.only(top: widget.screenHeight * 0.1),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.038),
              child: Card(
                color: Colors.white,
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: widget.screenHeight * 0.3,
                      color: Colors.white,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: widget.screenHeight * 0.06,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: widget.screenWidth * 0.76,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            CustomSnackBarTime.show(
                                                widget.ctx,
                                                widget.formattedDate,
                                                widget.formattedTime);
                                          },
                                          icon: const Icon(
                                            Icons.calendar_month_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                            width: widget.screenWidth * 0.04),
                                        DateTimeDisplay(
                                          formattedDate: widget.formattedDate,
                                          formattedTime: widget.formattedTime,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isExpanded
                                          ? Icons.edit_off_outlined
                                          : Icons.edit_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: toggleExpand,
                                  ),
                                ],
                              ),
                            ),
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              firstChild: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.screenWidth * 0.05,
                                ),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: widget.formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5),
                                        ValueListenableBuilder<String>(
                                          valueListenable:
                                              widget.billingNameNotifier,
                                          builder: (context, value, child) {
                                            return CustomTextFieldsaleupdate(
                                              hintText: 'Enter Full Name',
                                              labelText: 'Billing Name',
                                              controller: TextEditingController(
                                                  text: value),
                                              onChanged: (text) {
                                                widget.billingNameNotifier
                                                    .value = text;
                                              },
                                              validate: NameValidator.validate,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        ValueListenableBuilder<String>(
                                          valueListenable:
                                              widget.addressNameNotifier,
                                          builder: (context, value, child) {
                                            return CustomTextFieldsaleupdate(
                                              hintText: 'Enter Address',
                                              labelText: 'Billing Address',
                                              controller: TextEditingController(
                                                  text: value),
                                              onChanged: (text) {
                                                widget.addressNameNotifier
                                                    .value = text;
                                              },
                                              validate:
                                                  VentureValidator.validate,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        ValueListenableBuilder<String>(
                                          valueListenable: widget.phoneNotifier,
                                          builder: (context, value, child) {
                                            return CustomTextFieldsalePhoneupdate(
                                              hintText: '',
                                              labelText: 'Phone Number',
                                              controller: TextEditingController(
                                                  text: value),
                                              onChanged: (text) {
                                                widget.phoneNotifier.value =
                                                    text;
                                              },
                                              validate:
                                                  PhoneNumberValidator.validate,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              secondChild: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.screenWidth * 0.05,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    ValueListenableBuilder(
                                        valueListenable:
                                            widget.billingNameNotifier,
                                        builder: (context, value, child) {
                                          return InfoRow(
                                            iconData: Icons.person,
                                            iconColor: Colors.black,
                                            labelText: 'Billing name',
                                            valueText: value,
                                          );
                                        }),
                                    ValueListenableBuilder(
                                        valueListenable:
                                            widget.addressNameNotifier,
                                        builder: (context, value, child) {
                                          return InfoRow(
                                            iconData:
                                                Icons.location_on_outlined,
                                            iconColor: Colors.black,
                                            labelText: 'Address',
                                            valueText: value,
                                          );
                                        }),
                                    ValueListenableBuilder(
                                        valueListenable: widget.phoneNotifier,
                                        builder: (context, value, child) {
                                          return InfoRow(
                                            iconData: Icons.phone_forwarded,
                                            iconColor: Colors.black,
                                            labelText: 'Phone Number',
                                            valueText: value,
                                          );
                                        }),
                                  ],
                                ),
                              ),
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
        );
      },
    );
  }
}
