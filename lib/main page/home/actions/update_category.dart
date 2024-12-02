import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../db/functions/categoryfunction.dart';
import '../../add/productfiles_sub/check_out.dart';

class EditBottomSheet extends StatefulWidget {
  final String id;
  final String imagePath;
  final String categoryName;

  const EditBottomSheet({
    super.key,
    required this.id,
    required this.imagePath,
    required this.categoryName,
  });

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  late TextEditingController categoryController;
  late ValueNotifier<String> selectedImagePath;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.categoryName);
    selectedImagePath = ValueNotifier<String>(widget.imagePath);
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> updateCategoryInDB() async {
    String updatedCategoryName = categoryController.text;
    String updatedImagePath = selectedImagePath.value;

    bool success = await updateCategory(
      id: widget.id,
      categoryName: updatedCategoryName,
      imagePath: updatedImagePath,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category updated successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update category.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        height: screenHeight * 0.6,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color.fromARGB(255, 30, 59, 67),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.004),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 80.0,
                      height: 2.0,
                      color: const Color.fromARGB(255, 30, 59, 67),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03,),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          hintText: 'Enter category name',
                          prefixIcon: Icon(Icons.edit_calendar_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                        'assets/gif/welcome 2.json',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.4,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Animation not found');
                        },
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Center(
                            child: ClipOval(
                              child: ValueListenableBuilder<String>(
                                valueListenable: selectedImagePath,
                                builder: (context, value, child) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      image: DecorationImage(
                                        image: value.isNotEmpty
                                            ? FileImage(File(value))
                                                as ImageProvider
                                            : const AssetImage(
                                                'assets/category/file.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: CheckOut(
                        hintText: 'Update Category',
                        height: screenHeight * 0.06,
                        color: Colors.black,
                        onTap: () async {
                          await updateCategoryInDB();
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
