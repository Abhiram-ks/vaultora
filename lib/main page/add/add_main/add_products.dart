import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/field_decoration.dart';

import '../../../login/Login_autotications/decoration_landing.dart';
import '../add_product/check_out.dart';
import '../add_product/drowp_down.dart';
import '../add_product/sale_price.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();
  Color _quantityColor = Colors.black;
  int _quantity = 1;

  @override
  void dispose() {
    _imageNotifier.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageNotifier.value = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const MyAppBarTwo(
        titleText: 'Add Product',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
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
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 194, 194, 194),
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
                height: screenHeight * 0.06,
                hintText: 'Name of the item',
              ),
              SizedBox(height: screenHeight * 0.01),
              const FieldText(
                text: 'Description',
                icon: Icons.description_outlined,
              ),
              FieldDecoration(
                height: screenHeight * 0.15,
                hintText: 'Description of the item',
              ),
              SizedBox(height: screenHeight * 0.01),
              const FieldText(
                text: 'Purchase Price',
                icon: Icons.rocket_launch,
              ),
              FieldDecoration(
                height: screenHeight * 0.06,
                hintText: 'Enter Purchase Price',
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
              DropDown(
                height: screenHeight * 0.065,
                hintText: 'Category',
              ),
              SizedBox(height: screenHeight * 0.01),
              const FieldText(
                  text: 'Maximum Retail Price', icon: Icons.calculate_outlined),
              FieldDecoration(
                height: screenHeight * 0.06,
                hintText: 'MRP',
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
                          _quantityColor = Colors
                              .red; 
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), 
                      padding: EdgeInsets.all(8), 
                      backgroundColor: const Color.fromARGB(255, 188, 188, 188), 
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '$_quantity',
                      style: TextStyle(
                        fontSize: 19,
                        color:
                            _quantityColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_quantity < 25) {
                          _quantity++;
                          _quantityColor = Colors
                              .green;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), 
                      padding: EdgeInsets.all(8), 
                      backgroundColor: const Color.fromARGB(255, 188, 188, 188), 
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
               CheckOut(
                color: const Color.fromARGB(255, 10, 73, 110),
                height: screenHeight * 0.06,
                hintText: '₹ 24356',
                onTap: () {
                },
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
