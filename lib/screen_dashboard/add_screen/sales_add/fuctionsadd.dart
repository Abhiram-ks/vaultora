import 'package:flutter/material.dart';

import '../../../Color/colors.dart';
import '../../../login/Autotication_login/phone_validation.dart';
import '../../../login/Autotication_singup/validation.dart';
import '../../records/sales/subfiles_sales/logo_section.dart';
import '../../records/sales/subfiles_sales/sales_stack.dart';
import '../../records/sales/subfiles_sales/textfiled_sale.dart';

Widget dataForCustomerDetails(
  dynamic screenWidth,
  dynamic screenHeight,
  dynamic isExpanded,
  Function(bool) toggleExpanded,
  TextEditingController billingNameController,
  TextEditingController addressNameController,
  GlobalKey<FormState> formKey,
  TextEditingController phoneController,
) {
  return SalesStack(
    text: 'Add Sale Products',
    ther: Padding(
      padding: const EdgeInsets.only(top: 94.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
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
                            toggleExpanded(!isExpanded);
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
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextFieldsale(
                                controller: billingNameController,
                                hintText: 'Enter Full Name',
                                labelText: 'Billing Name',
                                validate: NameValidator.validate,
                              ),
                              const SizedBox(height: 16),
                              CustomTextFieldsale(
                                controller: addressNameController,
                                hintText: 'Enter Address',
                                labelText: 'Billing Address',
                                validate: VentureValidator.validate,
                              ),
                              const SizedBox(height: 16),
                              CustomTextFieldsalePhone(
                                controller: phoneController,
                                hintText: '',
                                labelText: 'Phone Number',
                                validate: PhoneNumberValidator.validate,
                              ),
                              const SizedBox(height: 16),
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
  );
}
