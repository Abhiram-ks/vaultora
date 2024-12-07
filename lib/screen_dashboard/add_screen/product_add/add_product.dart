import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/screen_dashboard/common/appbar.dart';

import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/product_records/subfiles_product_reocrd/digitfiled.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/product_records/subfiles_product_reocrd/drop_down.dart';
import 'package:vaultora_inventory_app/screen_dashboard/records/product/filtering_product/filed_decoration.dart';

import '../../../../Color/colors.dart';
import '../../../db/helpers/addfunction.dart';
import '../../../../db/models/user/user.dart';
import '../../../log/validation_login/orline_dec.dart';
import '../../common/snackbar.dart';
import '../../records/product/product_records/subfiles_product_reocrd/check_out.dart';

class AddProducts extends StatefulWidget {
  final UserModel userDetails;

  const AddProducts({super.key, required this.userDetails});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Color _quantityColor = black;
  int _quantity = 1;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');
  final TextEditingController _mrpController = TextEditingController();

  final ValueNotifier<String?> _selectedCategoryNotifier =
      ValueNotifier<String?>(null);

  final ValueNotifier<double> _totalPriceNotifier = ValueNotifier<double>(0.0);

  @override
  void dispose() {
    _imageNotifier.dispose();
    _itemNameController.dispose();
    _descriptionController.dispose();
    _purchasePriceController.dispose();
    _quantityController.dispose();
    _mrpController.dispose();
    _selectedCategoryNotifier.dispose();
    _totalPriceNotifier.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_imageNotifier.value == null) {return false;}
    if (_itemNameController.text.isEmpty) {return false;}
    if (_descriptionController.text.isEmpty) {return false;}
    if (_purchasePriceController.text.isEmpty) {return false;}
    if (_quantityController.text.isEmpty ||int.tryParse(_quantityController.text) == null) { return false;}
    if (_mrpController.text.isEmpty) {return false;}
    if (_selectedCategoryNotifier.value == null) {return false;}
    if (_totalPriceNotifier.value == 0.0) {return false;}return true;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageNotifier.value = File(pickedFile.path);
    }
  }

  void _updateTotalPrice() {
    final purchasePrice = double.tryParse(_purchasePriceController.text) ?? 0;
    _totalPriceNotifier.value = purchasePrice * _quantity;
  }

  Future<void> _addProduct() async {
    if (!_validateInputs() || _formKey.currentState?.validate() != true) {
      log("Validation failed.");
      CustomSnackBarCustomisation.show(
          context: context,
          message: 'Please fill in all fields. !',
          messageColor: blue,
          icon: Icons.info_outline_rounded,
          iconColor: blue);
      return;
    }
    String selectedCategory = _selectedCategoryNotifier.value ?? '';
    String imagePath = _imageNotifier.value?.path ?? '';

    bool success = await addItem(
      id: DateTime.now().toString(),
      userId: widget.userDetails.id,
      itemName: _itemNameController.text,
      description: _descriptionController.text,
      purchaseRate: _purchasePriceController.text,
      mrp: _mrpController.text,
      itemCount: _quantity.toString(),
      totalPurchase: _totalPriceNotifier.value.toString(),
      dropDown: selectedCategory,
      imagePath: imagePath,
    );

    if (success) {
      _showSuccessDialog();
    } else {
      CustomSnackBarCustomisation.show(
          context: context,
          message: "Failed to add product.!",
          messageColor: redColor,
          icon: Icons.sms_failed_outlined,
          iconColor: redColor);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Product added successfuly!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MyAppBarTwo(
        titleText: 'Add Product',
        bgColor: inside,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.024),
                GestureDetector(
                  onTap: () async {
                    await _pickImage();
                  },
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        height: screenHeight * 0.15,
                        width: screenHeight * 0.15,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 194, 194, 194),
                          shape: BoxShape.circle,
                        ),
                        child: ValueListenableBuilder<File?>(
                          valueListenable: _imageNotifier,
                          builder: (context, imageFile, child) {
                            if (imageFile != null) {
                              return Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                                width: screenHeight * 0.2,
                                height: screenHeight * 0.2,
                              );
                            } else {
                              return Lottie.asset(
                                'assets/category/addimage.json',
                                fit: BoxFit.contain,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                const FieldText(
                  text: 'Item Name',
                  icon: Icons.brightness_auto,
                ),
                FieldDecoration(
                  controller: _itemNameController,
                  height: screenHeight * 0.06,
                  hintText: 'Name of the item',
                  validate: InputValidator.validate,
                ),
                SizedBox(height: screenHeight * 0.01),
                const FieldText(
                  text: 'Description',
                  icon: Icons.description_outlined,
                ),
                FieldDecoration(
                  controller: _descriptionController,
                  height: screenHeight * 0.15,
                  hintText: 'Description of the item',
                  validate: InputValidator.validate,
                ),
                SizedBox(height: screenHeight * 0.01),
                const FieldText(
                  text: 'Purchase Price',
                  icon: Icons.rocket_launch,
                ),
                DigitField(
                  controller: _purchasePriceController,
                  height: screenHeight * 0.06,
                  hintText: 'Enter Purchase Price',
                  validate: DigitInputValidator.validate,
                  onChanged: (_) => _updateTotalPrice(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: OrCall(
                    text: 'Purchase Information',
                  ),
                ),
                const FieldText(
                  text: 'Select Category',
                  icon: Icons.move_down_sharp,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: DropDown(
                    height: screenHeight * 0.065,
                    hintText: 'Category',
                    selectedCategoryNotifier: _selectedCategoryNotifier,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                const FieldText(
                    text: 'Maximum Retail Price',
                    icon: Icons.calculate_outlined),
                DigitField(
                  controller: _mrpController,
                  height: screenHeight * 0.06,
                  hintText: 'MRP',
                  validate: DigitInputValidator.validate,
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity > 1) {
                            _quantity--;
                            _quantityColor = redColor;
                          }
                        });
                        _updateTotalPrice();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(8),
                        backgroundColor:
                            const Color.fromARGB(255, 188, 188, 188),
                      ),
                      child: Icon(Icons.remove, color: whiteColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '$_quantity',
                        style: TextStyle(
                          fontSize: 19,
                          color: _quantityColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity < 500) {
                            _quantity++;
                            _quantityColor = green;
                          }
                        });
                        _updateTotalPrice();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(8),
                        backgroundColor:
                            const Color.fromARGB(255, 188, 188, 188),
                      ),
                      child:  Icon(Icons.add, color: whiteColor),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                ValueListenableBuilder<double>(
                  valueListenable: _totalPriceNotifier,
                  builder: (context, totalPrice, child) {
                    return CheckOut(
                      color: const Color.fromARGB(255, 10, 73, 110),
                      height: screenHeight * 0.06,
                      hintText: '₹ ${totalPrice.toStringAsFixed(2)}',
                      onTap: () {
                        _addProduct();
                      },
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
